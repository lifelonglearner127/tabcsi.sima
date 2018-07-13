# frozen_string_literal: true

class AuditForm < ApplicationRecord
  has_and_belongs_to_many :questions

  validates :permit_name, presence: true, uniqueness: { case_sensitive: false }
end
