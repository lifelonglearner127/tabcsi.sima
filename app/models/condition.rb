# frozen_string_literal: true

class Condition < ApplicationRecord
  belongs_to :question

  validates :conditional_question_number, :condition_value, presence: true
end
