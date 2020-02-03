# frozen_string_literal: true

class GenerateQuestions
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
    now = Time.now

    entries = generate_random_questions.each_with_object([]) do |(key, value), acc|
      acc << {
        description: key,
        expected_answer: value,
        user_id: @user.id,
        created_at: now,
        updated_at: now
      }
    end

    Question.insert_all(entries)
  end

  private

  def generate_random_questions
    self.class.german_to_english_dictionary.sample(@amount)
  end
end
