# frozen_string_literal: true

class NewQuestionDecorator < Draper::Decorator
  decorates :question
  delegate_all

  attr_accessor :repeat

  def initialize(question, repeat: false)
    super(question)
    self.repeat = ActiveModel::Type::Boolean.new.cast(repeat)
  end
end
