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

class NewQuestion < Question
  class << self
    delegate :model_name, to: :Question
  end

  attr_reader :repeat

  def repeat=(value)
    @repeat = ActiveModel::Type::Boolean.new.cast(value)
  end
end
