class MainController < ApplicationController
  before_action :authenticate_user!, only: :restricted

  def home
  end

  def restricted
  end
end
