# frozen_string_literal: true

# The SqlCounter provides an overview of all the SQL queries performed within the given block.
#
# Every returned query expoes the `#model_name`, the `#sql` query as well as a few convenience
# methods like `#select?`, `#insert?`, `#update?`, `#delete?`.
#
# Example:
#
# ```
# queries = SqlCounter.capture do
#   get "/posts"
# end
#
# assert_equal 3, queries.count
# assert_equal 2, queries.select(&:select?).count
# assert_equal 1, queries.select(&:update?).count
# assert_equal "User", queries.first.model_name
# ```
class SqlCounter
  Query = Struct.new(:name, :sql) do
    def model_name
      name.split.first
    end

    def action_name
      name.split.last
    end

    def select?
      action_name == "Load"
    end

    def insert?
      action_name == "Create"
    end

    def update?
      action_name == "Update"
    end

    def delete?
      action_name == "Destroy"
    end
  end

  def self.capture
    counter = new

    ActiveSupport::Notifications.subscribe("sql.active_record", counter)
    yield
    ActiveSupport::Notifications.unsubscribe(counter)

    counter.queries
  end

  def queries
    @queries ||= []
  end

  def call(_name, _start, _finish, _message_id, values)
    return if values[:cached]
    return if values[:name].nil?

    queries << Query.new(values[:name], values[:sql])
  end
end
