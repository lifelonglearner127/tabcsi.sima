# frozen_string_literal: true

class AuditFormQuestion < ApplicationRecord
  belongs_to :audit_form
  has_many :conditions
  belongs_to :question
  has_many :choices, through: :question

  validates :question, uniqueness: { scope: :audit_form }

  delegate(
    :max_characters, :multiline, :other, :question_number, :question_text,
    :question_type, :source,
    to: :question
  )
end
