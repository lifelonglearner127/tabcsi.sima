# frozen_string_literal: true

class Condition < ApplicationRecord
  belongs_to :audit_form_question

  validates :condition_value, presence: true
end
