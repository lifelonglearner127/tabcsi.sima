# frozen_string_literal: true

class AuditForm < ApplicationRecord
  include LastUpdatable

  has_many :audit_form_questions, -> { order(:id) }, dependent: :destroy
  has_many :inspections, -> { order(:created_at) }, dependent: :nullify

  validates :permit_name, presence: true

  last_updated_by :audit_form_questions
end
