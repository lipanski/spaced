# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    # NOTE: use the browser cache efficiently
    return unless stale?(last_modified: Tag.last_modified_at_for(current_user.id))

    @tags = current_user.tags.order(name: :asc)
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      redirect_to tags_url, notice: "The tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    include_questions = params[:include_questions].present?

    Tag.transaction do
      Question.where(id: @tag.questions).destroy_all if include_questions
      @tag.destroy!
    end

    message =
      if include_questions
        "The questions were successfully removed."
      else
        "The tag was successfully removed."
      end

    redirect_to tags_url, notice: message
  end

  private

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
