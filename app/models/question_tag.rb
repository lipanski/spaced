# frozen_string_literal: true

# == Schema Information
#
# Table name: question_tags
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#  tag_id      :bigint           not null
#
# Indexes
#
#  index_question_tags_on_question_id  (question_id)
#  index_question_tags_on_tag_id       (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (tag_id => tags.id)
#

class QuestionTag < ApplicationRecord
  belongs_to :question
  belongs_to :tag
end
