# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tags_on_user_id           (user_id)
#  index_tags_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Tag < ApplicationRecord
  include CacheablePerUser

  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags

  validates :name,
    presence: true,
    uniqueness: { scope: :user_id },
    length: { maximum: 50 },
    format: { with: /\A[-\w\s]+\Z/, message: "only allows letters, numbers, spaces and dashes" }

  validate :validate_max_tags_not_reached

  def name=(value)
    super(value.strip)
  end

  private

  def validate_max_tags_not_reached
    return unless user.max_tags.present? && user.tags.count >= user.max_tags

    errors.add(:base, "You have reached the maximum number of tags allowed for your account")
  end
end
