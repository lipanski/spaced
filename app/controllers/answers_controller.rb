# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    question = current_user.questions.find(params[:question_id])
    answered = question.answer(current_user, params[:grade])

    unless answered
      flash[:alert] = "Couldn't save your answer. Please try again."
    end

    redirect_to user_root_url
  end
end
