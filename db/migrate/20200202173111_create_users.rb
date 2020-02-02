class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 250, null: false
      t.string :email, limit: 250, null: false
      t.integer :questions_per_day, null: false, default: 10

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
