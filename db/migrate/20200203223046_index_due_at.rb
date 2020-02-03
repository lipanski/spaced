# frozen_string_literal: true

class IndexDueAt < ActiveRecord::Migration[6.0]
  def change
    add_index :questions, [:user_id, :due_at]
  end
end
