# The SqlCounter provides an overview of all the SQL queries performed within the given block.
#
# Example:
#
# ```
# SqlCounter.capture do |queries|
#   get "/posts"
#
#   assert_equal 3, queries.count
#   assert_equal 2, queries.select(&:select?).count
#   assert_equal 1, queries.select(&:update?).count
#   assert_equal "User", queries.first.model_name
# end
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

  def self.capture(&block)
    new.tap do |counter|
      ActiveSupport::Notifications.subscribe("sql.active_record", counter)
      yield(counter.queries)
      ActiveSupport::Notifications.unsubscribe(counter)
    end
  end

  def queries
    @queries ||= []
  end

  def call(_name, _start, _finish, _message_id, values)
    return if values[:cached]
    return if values[:name].nil?

    self.queries << Query.new(values[:name], values[:sql])
  end
end
