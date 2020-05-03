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
      render :edit
    end
  end

  def destroy
    @tag.destroy!
    redirect_to tags_url, notice: "The tag was successfully removed."
  end

  private

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
