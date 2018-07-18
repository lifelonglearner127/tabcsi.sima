# frozen_string_literal: true

class AuditFormQuestionSerializer < ActiveModel::Serializer
  attributes(
    :question_text, :max_characters, :multiline, :finish
  )

  attribute :question_number, key: :question_id
  attribute :question_type, key: :type

  has_many :choices
  has_many :conditions
end

