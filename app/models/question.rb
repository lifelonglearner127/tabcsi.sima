# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, -> { order(:inspection_id) }, dependent: :nullify
  has_many :audit_form_questions, -> { order(:id) }, dependent: :destroy
  has_many :choices, -> { order(:id) }, dependent: :destroy
  has_many :question_help_items, as: :parent, dependent: :destroy

  validates :question_number, :question_text, :question_type, presence: true

  validates(
    :question_number,
    uniqueness: {
      scope: :built_on,
      case_sensitive: false
    }
  )

  enum question_type: %i[radio text_box drop_down]
  enum additional_type: %i[number]

  scope(
    :current_questions,
    -> { where(built_on: Setting.forms_build_date).order(:id) }
  )
end
