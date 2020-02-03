# frozen_string_literal: true

class QuestionDecorator < Draper::Decorator
  delegate :description, :answer, :persisted?

  def created_at
    I18n.l(object.created_at, format: :default)
  end
end
