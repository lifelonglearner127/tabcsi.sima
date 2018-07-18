# frozen_string_literal: true

class Condition < ApplicationRecord
  belongs_to :audit_form_question
  belongs_to :question, optional: true

  validates :condition_value, presence: true
end
