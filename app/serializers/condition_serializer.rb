# frozen_string_literal: true

class ConditionSerializer < ActiveModel::Serializer
  attributes :condition_value
  attribute :conditional_question_number, key: :conditional_question_id
end
