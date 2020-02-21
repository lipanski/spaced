require_dependency "api/application_controller"

module Api
  class QuestionsController < ApplicationController
    def index
      render json: { questions: [] }
    end
  end
end
