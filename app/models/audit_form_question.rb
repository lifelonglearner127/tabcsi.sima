# frozen_string_literal: true

class AuditFormQuestion < ApplicationRecord
  belongs_to :audit_form
  belongs_to :question
  has_many :choices, through: :question
  has_many :conditions, through: :question

  validates :audit_form, :question, presence: true
  validates :question_id, uniqueness: { scope: :audit_form_id }

  delegate(
    :max_characters, :multiline, :question_number, :question_text,
    :question_type,
    to: :question
  )
end
