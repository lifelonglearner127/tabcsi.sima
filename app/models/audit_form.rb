# frozen_string_literal: true

class AuditForm < ApplicationRecord
  PERMIT_NAMES = %i[
    BE BE-FB BF BG BG-FB BQ MB MB-FB N N-FB NB NE P Q RM V Y
  ].freeze

  has_many :audit_form_questions, -> { order(id: :asc) }

  validates :permit_name, presence: true, uniqueness: { case_sensitive: false }
end
