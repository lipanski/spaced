# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  description     :string(250)      not null
#  due_at          :datetime         not null
#  e_factor        :decimal(, )      default(2.5), not null
#  expected_answer :string(250)      not null
#  interval        :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_questions_on_user_id                  (user_id)
#  index_questions_on_user_id_and_created_at   (user_id,created_at)
#  index_questions_on_user_id_and_description  (user_id,description) UNIQUE
#  index_questions_on_user_id_and_due_at       (user_id,due_at)
#  index_questions_on_user_id_and_updated_at   (user_id,updated_at DESC)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Question < ApplicationRecord
  include CacheablePerUser
  include PgSearch::Model
  include Answerable

  # NOTE: simple and decently fast search
  pg_search_scope(:search,
    against: { description: "A", expected_answer: "D" },
    using: { tsearch: { prefix: true } })

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :user, presence: true
  validates :description, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 250 }
  validates :expected_answer, presence: true, length: { maximum: 250 }
  validate :validate_csv_tag_names

  # A virtual field to allow updating the tags association
  # from a simple comma/space-separated text field.
  def csv_tag_names=(value)
    tag_names = String(value).split(/\s|,|;/).map(&:strip).select(&:present?)

    self.tags = tag_names.map do |tag_name|
      tags.find { |tag| tag.name == tag_name } || Tag.where(user_id: user_id, name: tag_name).first_or_create
    end
  end

  def csv_tag_names
    tags.map(&:name).join(" ")
  end

  private

  def validate_csv_tag_names
    return if tags.all?(&:valid?)

    message = tags.map { |tag| tag.errors.full_messages }.flatten.uniq.map { |error| "#{error}. " }.join
    errors.add(:csv_tag_names, message)
  end
end
