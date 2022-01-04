# frozen_string_literal: true

module AnswersQuestions
  extend ActiveSupport::Concern

  included do
    has_many :questions, dependent: :destroy
    has_many :answers
  end

  def next_questions
    questions.where("due_at <= ?", Time.now.end_of_day).order(:due_at)
  end

  def next_question
    next_questions.first
  end
end
