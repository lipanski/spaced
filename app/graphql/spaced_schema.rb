# frozen_string_literal: true

class SpacedSchema < GraphQL::Schema
  default_max_page_size 50

  query(Types::QueryType)

  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  use GraphQL::Pagination::Connections
end
