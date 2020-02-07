# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 50, null: false

      t.timestamps
    end

    add_index :tags, [:user_id, :name], unique: true
  end
end
