# frozen_string_literal: true

class GenerateQuestions
  TAG = "random"

  # NOTE: a memoized class instance variable instead of a constant
  # to avoid unnecessary allocations at boot time
  def self.german_to_english_dictionary
    @german_to_english_dictionary ||= begin
      path = Rails.root.join("data", "german_english.json")
      json = File.read(path)

      JSON.parse(json).to_a
    end
  end

  def initialize(user, amount = 500)
    @user = user
    @amount = amount
  end

  def call
    Question.transaction do
      return false if @user.max_questions.present? && @user.questions.count + @amount > @user.max_questions

      now = Time.now

      question_entries = random_questions.each_with_object([]) do |(key, value), acc|
        acc << {
          description: key,
          expected_answer: value,
          user_id: @user.id,
          created_at: now,
          updated_at: now
        }
      end

      # NOTE: Speed up the bulk insert with insert_all. Use `returning` to collect ids (only works in Postgres).
      insert_results = Question.insert_all(question_entries, returning: [:id])

      tag = Tag.where(user_id: @user.id, name: TAG).first_or_create
      question_tag_entries = insert_results.map do |result|
        {
          question_id: result["id"],
          tag_id: tag.id,
          created_at: now,
          updated_at: now
        }
      end

      QuestionTag.insert_all(question_tag_entries)

      return true
    end

    false
  end

  private

  def random_questions
    self.class.german_to_english_dictionary.sample(@amount)
  end
end
