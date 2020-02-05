# frozen_string_literal: true

require "application_system_test_case"

class QuestionsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:without_questions)
    sign_in(@user)
  end

  test "adding a new question" do
    visit questions_url

    assert_selector "a", text: "Add a new question"
    click_on "Add a new question"

    fill_in "Question", with: "What is the capital of Romania?"
    fill_in "Expected answer", with: "Bucharest"
    click_on "Create Question"

    assert(Question.where(user: @user, description: "What is the capital of Romania?").exists?)
    assert_text "The question was successfully added."
    assert_equal(questions_path, current_path)
  end

  test "adding a new question with the 'Add another' option enabled" do
    visit questions_url

    assert_selector "a", text: "Add a new question"
    click_on "Add a new question"

    fill_in "Question", with: "What is the capital of Romania?"
    fill_in "Expected answer", with: "Bucharest"
    check "Add another"
    click_on "Create Question"

    assert(Question.where(user: @user, description: "What is the capital of Romania?").exists?)
    assert_text "The question was successfully added."
    assert_equal(new_question_path, current_path)
  end
end
