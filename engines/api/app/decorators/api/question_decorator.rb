# frozen_string_literal: true

module Api
  class QuestionDecorator < Draper::Decorator
    # NOTE: avoid delegate_all, the decorator should be the public interface for our model
    delegate :id, :description, :expected_answer, :tag_names

    def due_at
      object.due_at.iso8601
    end

    def created_at
      object.created_at.iso8601
    end

    # NOTE: use `as_json` + decorator instead of jbuilder and friends
    # it keeps things simple, domain-driven and works for most cases
    def as_json(*)
      {
        id: id,
        description: description,
        expected_answer: expected_answer,
        tags: tag_names,
        due_at: due_at,
        created_at: created_at
      }
    end
  end
end
