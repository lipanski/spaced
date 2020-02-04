# frozen_string_literal: true

require "test_helper"

class AnswerQuestionTest < ActiveSupport::TestCase
  setup do
    @user = users(:without_questions)
    @question = Question.create!(user: @user, description: "q", expected_answer: "q")
  end

  test "when the question hasn't been answered before and it was rated 0" do
    result = AnswerQuestion.new(@user, @question, 0).call

    assert(result)
    assert_equal(1, @question.interval)
    assert_equal(1.7, @question.e_factor)
    assert_in_delta(Time.zone.now + 1.day, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 0).exists?)
  end

  test "when the question hasn't been answered before and it was rated 1" do
    result = AnswerQuestion.new(@user, @question, 1).call

    assert(result)
    assert_equal(1, @question.interval)
    assert_equal(1.96, @question.e_factor)
    assert_in_delta(Time.zone.now + 1.day, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 1).exists?)
  end

  test "when the question hasn't been answered before and it was rated 3" do
    result = AnswerQuestion.new(@user, @question, 3).call

    assert(result)
    assert_equal(6, @question.interval)
    assert_equal(2.36, @question.e_factor)
    assert_in_delta(Time.zone.now + 6.days, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 3).exists?)
  end

  test "when the question hasn't been answered before and it was rated 5" do
    result = AnswerQuestion.new(@user, @question, 5).call

    assert(result)
    assert_equal(6, @question.interval)
    assert_equal(2.6, @question.e_factor)
    assert_in_delta(Time.zone.now + 6.days, @question.due_at, 5.minutes)
    assert_equal(1, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 5).exists?)
  end

  test "when the question has been answered for the second time, first time rated 3, second time rated 0" do
    AnswerQuestion.new(@user, @question, 3).call
    result = AnswerQuestion.new(@user, @question, 0).call

    assert(result)
    assert_equal(1, @question.interval)
    assert_equal(1.56, @question.e_factor)
    assert_in_delta(Time.zone.now + 1.day, @question.due_at, 5.minutes)
    assert_equal(2, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 0).exists?)
  end

  test "when the question has been answered for the second time, first time rated 3, second time rated 3" do
    AnswerQuestion.new(@user, @question, 3).call
    result = AnswerQuestion.new(@user, @question, 3).call

    assert(result)
    assert_equal(13, @question.interval)
    assert_equal(2.22, @question.e_factor)
    assert_in_delta(Time.zone.now + 13.days, @question.due_at, 5.minutes)
    assert_equal(2, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 3).exists?)
  end

  test "when the question has been answered for the second time, first time rated 3, second time rated 5" do
    AnswerQuestion.new(@user, @question, 3).call
    result = AnswerQuestion.new(@user, @question, 5).call

    assert(result)
    assert_equal(15, @question.interval)
    assert_equal(2.46, @question.e_factor)
    assert_in_delta(Time.zone.now + 15.days, @question.due_at, 5.minutes)
    assert_equal(2, Answer.where(user: @user, question: @question).count)
    assert(Answer.where(user: @user, question: @question, grade: 5).exists?)
  end

  test "when supplied with an invalid user" do
    assert_not(AnswerQuestion.new(nil, @question, 0).call)
  end

  test "when supplied with a negative grade" do
    assert_not(AnswerQuestion.new(@user, @question, -1).call)
    assert_not(Answer.where(user: @user).exists?)
  end

  test "when supplied with a grade above 5" do
    assert_not(AnswerQuestion.new(@user, @question, 6).call)
    assert_not(Answer.where(user: @user).exists?)
  end
end
