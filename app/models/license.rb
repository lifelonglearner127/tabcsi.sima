# frozen_string_literal: true

class License < ApplicationRecord
  LICENSE_NUMBER_REGEXP = /^(?<license_type>[A-Z]+)\s*(?<license_number>[0-9]+)$/ # rubocop:disable Metrics/LineLength

  belongs_to :company
  belongs_to :location
  has_and_belongs_to_many :users, -> { order(id: :asc) }

  validates :license_type, :license_number, presence: true

  validates(
    :license_number, uniqueness: { scope: :license_type, case_sensitive: false }
  )

  def self.split_license_number(clp)
    obj = LICENSE_NUMBER_REGEXP.match(clp&.upcase)&.named_captures
    if obj.blank?
      obj = { license_type: nil, license_number: nil }
    else
      obj.transform_keys!(&:to_sym)
    end

    if obj[:license_number].present?
      obj[:license_number] = obj[:license_number].to_i
    end

    obj
  end

  def permit_names
    name = license_type

    permit_names =
      if subordinate.present?
        subordinate.split(',').map { |s| "#{name}-#{s}" }
      else
        []
      end

    permit_names << name
  end
end
