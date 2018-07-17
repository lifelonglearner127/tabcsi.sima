# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :question, :license_number, :answer_value, presence: true
end
