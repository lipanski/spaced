# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    # NOTE: use the browser cache efficiently
    return unless stale?(last_modified: Question.last_modified_at_for(current_user.id))

    query = current_user.questions.includes(:tags).order(created_at: :desc)

    if params[:q].present?
      query = SearchQuestions.new(params[:q], query).call
    end

    @pagy, @questions = pagy_countless(query, items: 50)
    @questions = QuestionDecorator.decorate_collection(@questions)
  end

  def new
    @question = NewQuestion.new
  end

  def edit; end

  def create
    @question = NewQuestion.new({ user: current_user }.merge!(question_params))

    if @question.save
      redirect_url = @question.repeat ? new_question_url : questions_url
      redirect_to redirect_url, notice: "The question was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      redirect_to questions_url, notice: "The question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy!

    response = turbo_stream.remove(@question)
    response += turbo_stream.replace(:notifications, partial: "shared/notifications", locals: { notice: "The question was removed." })
    render turbo_stream: response
  end

  def today
    unless current_user.questions.exists?
      redirect_to questions_url
    end

    @question = QuestionDecorator.decorate(current_user.next_question)
  end

  def legend; end

  def generate
    generated = GenerateQuestions.new(current_user).call

    unless generated
      flash[:alert] = "Couldn't generate questions. Maybe you've exceeded your quota."
    end

    redirect_to questions_url
  end

  private

  def last_updated_at
    current_user.questions.order(updated_at: :desc).pick(:updated_at)
  end

  def set_question
    @question = current_user.questions.includes(:tags).find(params[:id])
  end

  def question_params
    params.require(:question).permit(:description, :expected_answer, :repeat, :csv_tag_names)
  end
end
