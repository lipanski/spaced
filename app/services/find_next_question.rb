# frozen_string_literal: true

class FindNextQuestion
  def initialize(user)
    @user = user
  end

  def call
    query = @user.questions
    query
      .where("due_at <= ?", Time.now.end_of_day)
      .order(due_at: :asc)
      .first
  end
end
