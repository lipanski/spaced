# frozen_string_literal: true

class QuestionIntervalAndEFactor < ActiveRecord::Migration[6.0]
  def change
    change_table :questions do |t|
      t.integer :interval, null: false, default: 1
      t.decimal :e_factor, null: false, default: 2.5
      t.timestamp :due_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end
