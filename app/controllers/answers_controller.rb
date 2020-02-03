# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    question = current_user.questions.find(params[:question_id])
    answer = Answer.new(answer_params.merge!(user: current_user, question: question))

    unless answer.save
      flash[:alert] = "Couldn't save your answer. Please try again."
    end

    redirect_to user_root_url
  end

  private

  def answer_params
    params.permit(:grade)
  end
end
