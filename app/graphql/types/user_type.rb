# frozen_string_literal: true

module Types
  class UserType < GraphQL::Schema::Object
    field :name, String, null: false
    field :questions, QuestionType.connection_type, null: false
    field :tags, TagType.connection_type, null: false
  end
end
