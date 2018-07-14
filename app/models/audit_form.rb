# frozen_string_literal: true

class AuditForm < ApplicationRecord
  has_many :audit_form_questions, -> { order(id: :asc) }

  validates :permit_name, presence: true, uniqueness: { case_sensitive: false }
end
