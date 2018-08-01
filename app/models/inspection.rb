# frozen_string_literal: true

class Inspection < ApplicationRecord
  belongs_to :audit_form
  belongs_to :location
  belongs_to :user

  validates :started_at, presence: true
end
