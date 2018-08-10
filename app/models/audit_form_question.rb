# frozen_string_literal: true

class AuditFormQuestion < ApplicationRecord
  include LastUpdatable

  belongs_to :audit_form
  has_many :conditions, -> { order(:id) }, dependent: :destroy
  belongs_to :question
  has_many :choices, -> { order(:id) }, through: :question

  validates :question, uniqueness: { scope: :audit_form }

  delegate(
    :max_characters, :multiline, :multiple, :other, :question_number,
    :question_text, :question_type, :source,
    to: :question
  )

  last_updated_by :choices, :conditions
end
