# frozen_string_literal: true

module Types
  class UserType < GraphQL::Schema::Object
    field :name, String, null: false
    field :questions, [QuestionType], null: false
  end
end
