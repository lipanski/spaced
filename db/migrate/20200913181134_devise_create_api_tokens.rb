# frozen_string_literal: true

class DeviseCreateApiTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :api_credentials do |t|
      t.references :user, null: false, foreign_key: true

      ## Database authenticatable
      t.string :client_id, null: false
      t.string :encrypted_password, null: false

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :api_credentials, :client_id, unique: true
  end
end
