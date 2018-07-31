# frozen_string_literal: true

class Vendor < ApplicationRecord
  LICENSE_NUMBER_REGEXP = /^(?<license_type>[A-Z]+)(?<license_number>[0-9]+)$/

  belongs_to :company, optional: true
  has_one :license
  has_one :location

  validates(
    :owner_id, :license_type, :license_number, :name, :address1, :city,
    :country, :postal_code,
    presence: true
  )

  validates(
    :license_number, uniqueness: { scope: :license_type, case_sensitive: false }
  )

  def self.split_license_number(license_number)
    LICENSE_NUMBER_REGEXP.match(license_number.upcase).named_captures
  end
end
