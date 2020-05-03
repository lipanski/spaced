# frozen_string_literal: true

require "test_helper"

class SearchQuestionsTest < ActiveSupport::TestCase
  setup do
    @user = users(:without_questions)
  end

  test "finds questions based on the description" do
    correct = [Question.create!(user: @user, description: "aaa", expected_answer: "answer")]
    Question.create!(user: @user, description: "bbb", expected_answer: "answer")
    Question.create!(user: @user, description: "ccc", expected_answer: "answer")

    assert_equal(correct, SearchQuestions.new("aaa").call)
  end

  test "finds questions based on the answer" do
    correct = [Question.create!(user: @user, description: "description a", expected_answer: "aaa")]
    Question.create!(user: @user, description: "description b", expected_answer: "bbb")
    Question.create!(user: @user, description: "description c", expected_answer: "ccc")

    assert_equal(correct, SearchQuestions.new("aaa").call)
  end

  test "scopes searches to the provided relation" do
    correct = [Question.create!(user: @user, description: "description a", expected_answer: "aaa")]
    Question.create!(user: users(:mario), description: "description b", expected_answer: "bbb")
    Question.create!(user: users(:luigi), description: "description c", expected_answer: "ccc")

    assert_equal(correct, SearchQuestions.new("description", Question.where(user: @user)).call)
  end

  test "finds questions based on a tag" do
    correct =
      [
        Question.create!(user: @user, description: "desc a", expected_answer: "answer", csv_tag_names: "aaa ddd")
      ]
    Question.create!(user: @user, description: "desc b", expected_answer: "answer", csv_tag_names: "bbb eee")
    Question.create!(user: @user, description: "desc c", expected_answer: "answer", csv_tag_names: "ccc")

    assert_equal(correct, SearchQuestions.new("tag:aaa").call)
  end

  test "finds questions based on multiple tags" do
    correct =
      [
        Question.create!(user: @user, description: "desc a", expected_answer: "answer", csv_tag_names: "aaa ddd"),
        Question.create!(user: @user, description: "desc b", expected_answer: "answer", csv_tag_names: "bbb eee")
      ]
    Question.create!(user: @user, description: "desc c", expected_answer: "answer", csv_tag_names: "ccc")

    assert_equal(correct, SearchQuestions.new("tag:aaa tag:eee").call)
  end

  test "finds questions based on a quoted tag" do
    correct =
      [
        Question.create!(user: @user, description: "desc a", expected_answer: "answer", csv_tag_names: "aaa ddd")
      ]
    Question.create!(user: @user, description: "desc b", expected_answer: "answer", csv_tag_names: "bbb eee")
    Question.create!(user: @user, description: "desc c", expected_answer: "answer", csv_tag_names: "ccc")

    assert_equal(correct, SearchQuestions.new("tag:\"aaa\"").call)
  end

  test "finds questions based on multiple mixed tags" do
    correct =
      [
        Question.create!(user: @user, description: "desc a", expected_answer: "answer", csv_tag_names: "aaa ddd"),
        Question.create!(user: @user, description: "desc b", expected_answer: "answer", csv_tag_names: "bbb eee")
      ]
    Question.create!(user: @user, description: "desc c", expected_answer: "answer", csv_tag_names: "ccc")

    assert_equal(correct, SearchQuestions.new("tag:aaa tag:\"eee\"").call)
  end

  test "finds questions based on tags and a description" do
    correct =
      [
        Question.create!(user: @user, description: "desc a", expected_answer: "answer", csv_tag_names: "aaa ddd")
      ]
    Question.create!(user: @user, description: "b", expected_answer: "answer", csv_tag_names: "bbb eee")
    Question.create!(user: @user, description: "c", expected_answer: "answer", csv_tag_names: "ccc")

    assert_equal(correct, SearchQuestions.new("tag:aaa tag:eee desc").call)
  end
end
