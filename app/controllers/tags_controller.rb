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

  def update; end

  def destroy
    @tag.destroy!
    redirect_to tags_url, notice: "The tag was successfully removed."
  end

  private

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end
end
