# frozen_string_literal: true

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
