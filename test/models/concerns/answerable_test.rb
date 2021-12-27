# frozen_string_literal: true

require "test_helper"

class AnswerableTest < ActiveSupport::TestCase
  setup do
    @user = users(:without_questions)
    @question = Question.create!(user: @user, description: "q", expected_answer: "q")
  end

  test "when the question hasn't been answered before and it was rated 0" do
    result = @question.answer(@user, 0)

    assert(result)
    assert_equal(1, @question.interval)
    assert_equal(1.7, @question.e_factor)
    assert_in_delta(Time.zone.now + 1.day, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 0).exists?)
  end

  test "when the question hasn't been answered before and it was rated 1" do
    result = @question.answer(@user, 1)

    assert(result)
    assert_equal(1, @question.interval)
    assert_equal(1.96, @question.e_factor)
    assert_in_delta(Time.zone.now + 1.day, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 1).exists?)
  end

  test "when the question hasn't been answered before and it was rated 3" do
    result = @question.answer(@user, 3)

    assert(result)
    assert_equal(6, @question.interval)
    assert_equal(2.36, @question.e_factor)
    assert_in_delta(Time.zone.now + 6.days, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 3).exists?)
  end

  test "when the question hasn't been answered before and it was rated 5" do
    result = @question.answer(@user, 5)

    assert(result)
    assert_equal(6, @question.interval)
    assert_equal(2.6, @question.e_factor)
    assert_in_delta(Time.zone.now + 6.days, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 5).exists?)
  end

  test "when the question has been answered for the second time, first time rated 3, second time rated 0" do
    @question.answer(@user, 3)
    result = @question.answer(@user, 0)

    assert(result)
    assert_equal(1, @question.interval)
    assert_equal(1.56, @question.e_factor)
    assert_in_delta(Time.zone.now + 1.day, @question.due_at, 5.minutes)
    assert_equal(2, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 0).exists?)
  end

  test "when the question has been answered for the second time, first time rated 3, second time rated 3" do
    @question.answer(@user, 3)
    result = @question.answer(@user, 3)

    assert(result)
    assert_equal(13, @question.interval)
    assert_equal(2.22, @question.e_factor)
    assert_in_delta(Time.zone.now + 13.days, @question.due_at, 5.minutes)
    assert_equal(2, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 3).exists?)
  end

  test "when the question has been answered for the second time, first time rated 3, second time rated 5" do
    @question.answer(@user, 3)
    result = @question.answer(@user, 5)

    assert(result)
    assert_equal(15, @question.interval)
    assert_equal(2.46, @question.e_factor)
    assert_in_delta(Time.zone.now + 15.days, @question.due_at, 5.minutes)
    assert_equal(2, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 5).exists?)
  end

  test "when supplied with an invalid user" do
    assert_not(@question.answer(nil, 3))
  end

  test "when supplied with a negative grade" do
    assert_not(@question.answer(@user, -1))
    assert_not(Answer.where(user: @user).exists?)
  end

  test "when supplied with a grade above 5" do
    assert_not(@question.answer(@user, 6))
    assert_not(Answer.where(user: @user).exists?)
  end
end
