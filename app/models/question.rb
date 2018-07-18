# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, -> { order(id: :asc) }
  has_many :audit_form_questions, -> { order(id: :asc) }
  has_many :choices, -> { order(id: :asc) }
  has_many :conditions, -> { order(id: :asc) }

  validates :question_number, :question_text, :question_type, presence: true
  validates :question_number, uniqueness: { case_sensitive: false }

  enum question_type: %i[radio text_box drop_down]
end
