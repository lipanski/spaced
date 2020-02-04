# frozen_string_literal: true

class QuestionDecorator < Draper::Decorator
  # NOTE: avoid delegate_all, the decorator should be the public interface for our model
  delegate :description, :expected_answer, :persisted?

  def created_at
    I18n.l(object.created_at, format: :default)
  end
end
