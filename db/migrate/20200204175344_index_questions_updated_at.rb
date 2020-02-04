# frozen_string_literal: true

class IndexQuestionsUpdatedAt < ActiveRecord::Migration[6.0]
  def change
    add_index :questions, [:user_id, :updated_at], order: { updated_at: :desc }
  end
end
