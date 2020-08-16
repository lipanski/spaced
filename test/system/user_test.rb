# frozen_string_literal: true

require "application_system_test_case"

class UserTest < ApplicationSystemTestCase
  test "user can register" do
    visit root_url

    assert_selector "a", text: "Register"
    click_on "Register"

    fill_in "Name", with: "Me"
    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    click_on "Sign up"

    assert User.where(name: "Me", email: "me@example.com").exists?
    assert_equal(questions_path, current_path)
  end

  test "user can log in" do
    User.create!(name: "Me", email: "me@example.com", password: "secret")

    visit root_url

    assert_selector "a", text: "Login"
    click_on "Login"

    fill_in "Email", with: "me@example.com"
    fill_in "Password", with: "secret"
    click_on "Log in"

    assert_equal(questions_path, current_path)
  end
end
