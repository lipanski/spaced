class UserToken < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token, :string, limit: 50
    add_index :users, :token
  end
end
