# frozen_string_literal: true

class AnswerSerializer < ActiveModel::Serializer
  attributes :question_id, :license_number
  attribute :answer_value, key: :value

  belongs_to :question

  def question_id
    object.question.question_number
  end
end
