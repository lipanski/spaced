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

require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  setup do
    @user = users(:without_questions)
  end

  test "setting new tags with csv_tag_names" do
    question = Question.new(
      user: @user,
      description: "What is the capital of France?",
      expected_answer: "Paris",
      csv_tag_names: "capitals history"
    )

    assert_difference("Question.count", 1) do
      assert_no_difference("Tag.count", 2) do
        assert(question.save)
      end
    end

    question.reload
    assert_equal(2, question.tags.count)
    assert_equal(["capitals", "history"], question.tags.map(&:name).sort)
  end

  test "setting existing tags with csv_tag_names" do
    Tag.create!(user: @user, name: "capitals")
    Tag.create!(user: @user, name: "history")

    question = Question.new(
      user: @user,
      description: "What is the capital of France?",
      expected_answer: "Paris",
      csv_tag_names: "capitals history"
    )

    assert_difference("Question.count", 1) do
      assert_no_difference("Tag.count") do
        assert(question.save)
      end
    end

    question.reload
    assert_equal(2, question.tags.count)
    assert_equal(["capitals", "history"], question.tags.map(&:name).sort)
  end
end
