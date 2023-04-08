# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string(250)      not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  max_questions          :integer          default(100)
#  max_tags               :integer          default(50)
#  name                   :string(250)      not null
#  questions_per_day      :integer          default(10), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
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
