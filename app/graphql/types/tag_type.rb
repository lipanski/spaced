# frozen_string_literal: true

module Types
  class TagType < GraphQL::Schema::Object
    field :name, String, null: false
    field :questions, QuestionType.connection_type, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
