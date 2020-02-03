class QuestionDecorator < Draper::Decorator
  delegate :description, :answer, :persisted?

  def created_at
    l(object.created_at, format: :default)
  end
end
