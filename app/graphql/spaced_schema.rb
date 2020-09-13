# frozen_string_literal: true

class SpacedSchema < GraphQL::Schema
  query(Types::QueryType)

  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  use GraphQL::Pagination::Connections
end
