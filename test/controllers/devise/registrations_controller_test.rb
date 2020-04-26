# frozen_string_literal: true

require "test_helper"

module Devise
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    test "DELETE /users removes the user and redirects back to root" do
      user = users(:mario)

      sign_in(user)
      delete(user_registration_url)

      assert_raises(ActiveRecord::RecordNotFound) do
        user.reload
      end

      assert_redirected_to(root_url)
    end

    test "DELETE /users removes all the user's questions" do
      user = User.create!(name: "Delete Me", email: "delete-me@example.com", password: "secret")

      5.times do |i|
        Question.create!(
          user: user,
          description: "question #{i}",
          expected_answer: "answer #{i}",
          csv_tag_names: "a b c d"
        )
      end

      sign_in(user)

      assert_difference("Question.count", -5) do
        delete(user_registration_url)
      end
    end

    test "DELETE /users removes all the user's tags" do
      user = User.create!(name: "Delete Me", email: "delete-me@example.com", password: "secret")

      5.times do |i|
        Question.create!(
          user: user,
          description: "question #{i}",
          expected_answer: "answer #{i}",
          csv_tag_names: "a b c d"
        )
      end

      sign_in(user)

      assert_difference("Tag.count", -4) do
        delete(user_registration_url)
      end
    end

    test "DELETE /users removes all the user's answers" do
      user = User.create!(name: "Delete Me", email: "delete-me@example.com", password: "secret")

      5.times do |i|
        question = Question.create!(
          user: user,
          description: "question #{i}",
          expected_answer: "answer #{i}",
          csv_tag_names: "a b c d"
        )

        Answer.create!(user: user, question: question, grade: 3)
      end

      sign_in(user)

      assert_difference("Answer.count", -5) do
        delete(user_registration_url)
      end
    end
  end
end
