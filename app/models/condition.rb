# frozen_string_literal: true

class Condition < ApplicationRecord
  belongs_to :question

  validates(
    :question, :conditional_question_number, :condition_value, presence: true
  )
end
