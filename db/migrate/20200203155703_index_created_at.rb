# frozen_string_literal: true

class IndexCreatedAt < ActiveRecord::Migration[6.0]
  def change
    add_index :questions, [:user_id, :created_at]
  end
end
