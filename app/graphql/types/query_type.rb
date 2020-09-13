# frozen_string_literal: true

module Types
  class QueryType < GraphQL::Schema::Object
    field :current_user, UserType, null: true
    def current_user
      context[:current_user]
    end
  end
end
