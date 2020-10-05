# frozen_string_literal: true

require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:mario)
    sign_in(@user)
  end

  test "GET /questions should not trigger N+1 queries" do
    5.times { |i| Question.create!(user: @user, description: "q #{i}", expected_answer: "q") }

    # NOTE: Test against N+1 query regressions
    queries = SqlSpy.track { get(questions_url) }

    select_queries_by_model = queries.select(&:select?).group_by(&:model_name)

    assert select_queries_by_model.all? { |_, group| group.count <= 2 }, "You might have N+1 queries!"
    assert_response 200
  end

  test "POST /questions should create a question" do
    assert_difference("Question.count") do
      post(questions_url, params: {
        question: {
          expected_answer: "When did the French revolution take place?",
          description: "1789",
          repeat: "0"
        }
      })
    end

    assert_equal("The question was successfully added.", flash[:notice])
    assert_redirected_to(questions_url)
  end

  test "POST /questions with repeat enabled should create a question and redirect back to the form" do
    assert_difference("Question.count") do
      post(questions_url, params: {
        question: {
          expected_answer: "When did the French revolution take place?",
          description: "1789",
          repeat: "1"
        }
      })
    end

    assert_equal("The question was successfully added.", flash[:notice])
    assert_redirected_to(new_question_url)
  end

  test "DELETE /questions/:id should destroy the question" do
    question = Question.create!(user: @user, description: "q", expected_answer: "q")

    assert_difference("Question.count", -1) do
      delete(question_url(question))
    end

    assert_redirected_to(questions_url)
  end
end
