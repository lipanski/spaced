# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  answer      :string(250)      not null
#  description :string(250)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_questions_on_description  (description) UNIQUE
#  index_questions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Question < ApplicationRecord
  belongs_to :user

  validates :description, presence: true, length: { maximum: 250 }
  validates :answer, presence: true, length: { maximum: 250 }
end
