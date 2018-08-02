# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :inspection
  
  validates(
    :question_number,
    presence: true,
    uniqueness: { scope: :inspection, case_sensitive: false }
  )
end
