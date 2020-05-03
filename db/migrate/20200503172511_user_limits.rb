# frozen_string_literal: true

class UserLimits < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :max_questions, :integer, default: 100
    add_column :users, :max_tags, :integer, default: 50
  end
end
