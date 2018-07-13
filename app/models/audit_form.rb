# frozen_string_literal: true

class AuditForm < ApplicationRecord
  validates :permit_name, presence: true, uniqueness: { case_sensitive: false }
end
