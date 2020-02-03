# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.where(user: current_user).all
  end

  def new
    @question = NewQuestionDecorator.new(Question.new)
  end

  def edit; end

  def create
    raw_question = Question.new(question_params.merge!(user: current_user))
    @question = NewQuestionDecorator.new(raw_question, repeat: params[:question][:repeat])

    if @question.save
      redirect_url = @question.repeat ? new_question_url : questions_url
      redirect_to redirect_url, notice: "The question was successfully added."
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to questions_url, notice: "The question was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: "The question was successfully removed."
  end

  private

  def set_question
    @question = Question.where(user: current_user).find(params[:id])
  end

  def question_params
    params.require(:question).permit(:description, :answer)
  end
end
