# frozen_string_literal: true

class MainController < ApplicationController
  def home; end

  def start
    redirect_to user_signed_in? ? user_root_path : new_user_registration_path
  end

  def about; end
end
