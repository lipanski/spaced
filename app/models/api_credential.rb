# frozen_string_literal: true

# == Schema Information
#
# Table name: api_credentials
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  encrypted_password :string           not null
#  failed_attempts    :integer          default(0), not null
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  locked_at          :datetime
#  sign_in_count      :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :string           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_api_credentials_on_client_id  (client_id) UNIQUE
#  index_api_credentials_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class ApiCredential < ApplicationRecord
  devise :database_authenticatable, :lockable, :trackable,
    authentication_keys: [:client_id],
    http_authenticatable: true
  alias_attribute :client_secret, :password

  belongs_to :user
end
