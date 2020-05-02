# frozen_string_literal: true

class QuestionDecorator < Draper::Decorator
  # NOTE: avoid delegate_all, the decorator should be the public interface for our model
  delegate :id, :description, :expected_answer, :persisted?

  def created_at
    I18n.l(object.created_at, format: :default)
  end

  def tag_names
    object.tags.sort_by(&:name).map(&:name)
  end
end
