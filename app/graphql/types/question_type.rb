# frozen_string_literal: true

module Types
  class QuestionType < GraphQL::Schema::Object
    field :description, String, null: false, description: "The actual question"
    field :expected_answer, String, null: false, description: "The expected answer"
    field :due_at, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
