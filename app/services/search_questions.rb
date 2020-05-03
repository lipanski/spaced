# frozen_string_literal: true

class SearchQuestions
  # Splits single words or multiple words surrounded by double quotes
  SPLIT_PATTERN = /\s+(?=(?:[^"]|"[^"]*")*$)/

  def initialize(query, relation = Question.includes(:tags))
    @words = query.split(SPLIT_PATTERN)
    @relation = relation
  end

  def call
    tag_words, search_words = @words.partition { |word| word.start_with?("tag:") }

    if tag_words.present?
      tag_words.map! { |word| word.delete_prefix("tag:").gsub(/\A"|"\Z/, "") }
      @relation = @relation.where(tags: { id: Tag.where(name: tag_words) })
    end

    if search_words.present?
      @relation = @relation.reorder("").search(search_words.join(" "))
    end

    @relation
  end
end
