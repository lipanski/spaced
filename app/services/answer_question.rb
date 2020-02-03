# 1. Split the knowledge into smallest possible items.
#
# 2. With all items associate an E-Factor equal to 2.5.
#
# 3. Repeat items using the following intervals:
#
# I(1):=1
# I(2):=6
# for n>2: I(n):=I(n-1)*EF
# where:
# I(n) - inter-repetition interval after the n-th repetition (in days),
# EF - E-Factor of a given item
# If interval is a fraction, round it up to the nearest integer.
#
# 4. After each repetition assess the quality of repetition response in 0-5 grade scale:
#
# 5 - perfect response
# 4 - correct response after a hesitation
# 3 - correct response recalled with serious difficulty
# 2 - incorrect response; where the correct one seemed easy to recall
# 1 - incorrect response; the correct one remembered
# 0 - complete blackout.
#
# 5. After each repetition modify the E-Factor of the recently repeated item according to the formula:
#
# EF':=EF+(0.1-(5-q)*(0.08+(5-q)*0.02))
# where:
# EF' - new value of the E-Factor,
# EF - old value of the E-Factor,
# q - quality of the response in the 0-5 grade scale.
#
# If EF is less than 1.3 then let EF be 1.3.
#
# 6. If the quality response was lower than 3 then start repetitions for the item from the beginning without changing the E-Factor (i.e. use intervals I(1), I(2) etc. as if the item was memorized anew).
#
# 7. After each repetition session of a given day repeat again all items that scored below four in the quality assessment. Continue the repetitions until all of these items score at least four.

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
        last_answered_at: Time.now
      ) || (raise ActiveRecord::Rollback)

      Answer.create(
        user: @user,
        question: @question,
        grade: @grade
      ) || (raise ActiveRecord::Rollback)

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
      computed = @question.e_factor + (0.1 - (5 - @grade) * (0.08 + (5 - @grade) * 0.02))
      [computed, 1.3].max
    end
  end
end
