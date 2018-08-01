# frozen_string_literal: true

class Condition < ApplicationRecord
  include LastUpdatable

  belongs_to :audit_form_question

  validates :condition_value, presence: true

  last_updated_by
end
