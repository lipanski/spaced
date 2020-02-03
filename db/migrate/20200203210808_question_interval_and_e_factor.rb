class QuestionIntervalAndEFactor < ActiveRecord::Migration[6.0]
  def change
    change_table :questions do |t|
      t.integer :interval, null: false, default: 1
      t.decimal :e_factor, null: false, default: 2.5
      t.datetime :last_answered_at
    end
  end
end
