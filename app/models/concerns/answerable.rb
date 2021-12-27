# frozen_string_literal: true

module Answerable
  include ActiveSupport::Concern

  # NOTE: Answers a question using the SuperMemo2 algorithm to rate and track progress
  def answer(user, grade)
    grade = Integer(grade)
    interval = new_interval(grade)
    e_factor = new_e_factor(grade)

    Answer.transaction do
      update(
        interval: interval,
        e_factor: e_factor,
        due_at: Time.now + interval.days
      ) || (raise ActiveRecord::Rollback)

      Answer.new(
        user: user,
        question: self,
        grade: grade
      ).save || (raise ActiveRecord::Rollback)

      true
    end
  end

  private

  def new_interval(grade)
    return 1 if grade < 3
    return 6 if interval == 1

    (interval * new_e_factor(grade)).round
  end

  def new_e_factor(grade)
    computed = e_factor + (0.1 - ((5 - grade) * (0.08 + ((5 - grade) * 0.02))))
    [computed.round(4), 1.3].max
  end
end
