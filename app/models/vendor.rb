# frozen_string_literal: true

class Vendor < ApplicationRecord
  belongs_to :company, optional: true
  has_one :license
  has_one :location

  validates(
    :owner_id, :license_number, :name, :address1, :city, :country, :postal_code,
    presence: true
  )

  validates :license_number, uniqueness: { case_sensitive: false }
end
