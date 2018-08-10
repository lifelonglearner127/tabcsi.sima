# frozen_string_literal: true

class License < ApplicationRecord
  LICENSE_NUMBER_REGEXP = /^(?<license_type>[A-Z]+)\s*(?<license_number>[0-9]+)$/ # rubocop:disable Metrics/LineLength

  belongs_to :company
  belongs_to :location
  has_and_belongs_to_many :users, -> { order(:id) }

  validates :license_type, :license_number, :status, presence: true

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
    permit_names = subordinate_combinations.map { |c| "#{name}/#{c.join('/')}" }
    permit_names << name
  end

  private

  def subordinate_combinations
    combs = []

    if subordinate.present?
      subs = subordinate.split(',')
      subs.size.downto(1) do |i|
        combs.push(*subs.combination(i))
      end
    end

    combs
  end
end
