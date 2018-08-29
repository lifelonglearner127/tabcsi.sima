# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, -> { order(:id) }, dependent: :nullify
  has_many :audit_form_questions, -> { order(:id) }, dependent: :destroy
  has_many :choices, -> { order(:id) }, dependent: :destroy

  validates :question_number, :question_text, :question_type, presence: true

  enum question_type: %i[radio text_box drop_down]
end
