# frozen_string_literal: true

require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:mario)
    sign_in(@user)
  end

  test "DELETE /tags/:id should destroy the tag" do
    tag = Tag.create!(user: @user, name: "aaa")

    assert_difference("Tag.count", -1) do
      delete(tag_url(tag))
    end

    assert_redirected_to(tags_url)
  end

  test "DELETE /tags/:id doesn't remove the previously tagged questions" do
    tag = Tag.create!(user: @user, name: "aaa")
    Question.create!(user: @user, description: "d1", expected_answer: "a", csv_tag_names: "aaa")
    Question.create!(user: @user, description: "d2", expected_answer: "a", csv_tag_names: "aaa")

    assert_difference("Tag.count", -1) do
      assert_difference("Question.count", 0) do
        delete(tag_url(tag))
      end
    end

    assert_redirected_to(tags_url)
  end

  test "DELETE /tags/:id/?include_questions=1 removes the tag and the tagged questions" do
    tag = Tag.create!(user: @user, name: "aaa")
    Question.create!(user: @user, description: "d1", expected_answer: "a", csv_tag_names: "aaa")
    Question.create!(user: @user, description: "d2", expected_answer: "a", csv_tag_names: "aaa")

    assert_difference("Question.count", -2) do
      assert_difference("Tag.count", -1) do
        delete(tag_url(tag, include_questions: 1))
      end
    end

    assert_redirected_to(tags_url)
  end
end
