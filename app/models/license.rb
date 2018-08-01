# frozen_string_literal: true

class License < ApplicationRecord
  LICENSE_NUMBER_REGEXP = /^(?<license_type>[A-Z]+)(?<license_number>[0-9]+)$/

  belongs_to :company
  belongs_to :location
  has_and_belongs_to_many :users, -> { order(id: :asc) }

  validates :license_type, :license_number, presence: true

  validates(
    :license_number, uniqueness: { scope: :license_type, case_sensitive: false }
  )

  def self.split_license_number(license_number)
    LICENSE_NUMBER_REGEXP.match(license_number.upcase).named_captures
  end

  def permit_names
    name = license_type

    return [name] if subordinate.blank?

    subordinate.split(',').map { |s| "#{name}-#{s}" }
  end
end
