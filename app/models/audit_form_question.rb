# frozen_string_literal: true

class AuditFormQuestion < ApplicationRecord
  belongs_to :audit_form
  belongs_to :question
  has_many :choices, through: :question
  has_many :conditions

  validates :question, uniqueness: { scope: :audit_form }

  delegate(
    :max_characters, :multiline, :question_number, :question_text,
    :question_type,
    to: :question
  )
end
