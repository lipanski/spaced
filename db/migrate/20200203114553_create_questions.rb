# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description, limit: 250, null: false
      t.string :expected_answer, limit: 250, null: false

      t.timestamps
    end

    add_index :questions, [:user_id, :description], unique: true
  end
end
