# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#next_question returns nil when the user doesn't have any questions" do
    user = users(:without_questions)
    assert_nil(user.next_question)
  end

  test "#next_question returns the most urgent question based on the due at" do
    user = users(:without_questions)
    today = Time.zone.today

    Question.create!(user: user, description: "a", expected_answer: "a", due_at: today + 5.hours)
    expected = Question.create!(user: user, description: "b", expected_answer: "b", due_at: today + 2.hours)
    Question.create!(user: user, description: "c", expected_answer: "c", due_at: today + 4.hours)

    assert_equal(expected, user.next_question)
  end

  test "#next_question ignores questions due after midnight" do
    user = users(:without_questions)
    tomorrow = Time.zone.tomorrow

    Question.create!(user: user, description: "a", expected_answer: "a", due_at: tomorrow + 5.hours)
    Question.create!(user: user, description: "b", expected_answer: "b", due_at: tomorrow + 2.hours)
    Question.create!(user: user, description: "c", expected_answer: "c", due_at: tomorrow + 4.hours)

    assert_nil(user.next_question)
  end
end
