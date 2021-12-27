# frozen_string_literal: true

# NOTE: a service object implementing the SuperMemo2 algorithm
class AnswerQuestion
  def initialize(user, question, grade)
    @user = user
    @question = question
    @grade = Integer(grade)
  end

  def call
    Answer.transaction do
      @question.update(
        interval: new_interval,
        e_factor: new_e_factor,
        due_at: Time.now + new_interval.days
      ) || (raise ActiveRecord::Rollback)

      Answer.new(
        user: @user,
        question: @question,
        grade: @grade
      ).save || (raise ActiveRecord::Rollback)

      true
    end
  end

  private

  def new_interval
    return 1 if @grade < 3
    return 6 if @question.interval == 1

    (@question.interval * new_e_factor).round
  end

  def new_e_factor
    @new_e_factor ||= begin
      computed = @question.e_factor + (0.1 - ((5 - @grade) * (0.08 + ((5 - @grade) * 0.02))))
      [computed.round(4), 1.3].max
    end
  end
end
