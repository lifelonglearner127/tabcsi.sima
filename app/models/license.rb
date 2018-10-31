# frozen_string_literal: true

class License < ApplicationRecord
  LICENSE_NUMBER_REGEXP =
    /^(?<license_type>[A-Z]+)\s*(?<license_number>[0-9]+)$/.freeze

  belongs_to :company, -> { with_discarded }
  belongs_to :location, -> { with_discarded }

  belongs_to(
    :unscoped_company,
    -> { with_discarded },
    class_name: 'Company',
    foreign_key: 'company_id',
    optional: true
  )

  belongs_to(
    :unscoped_location,
    -> { with_discarded },
    class_name: 'Location',
    foreign_key: 'location_id',
    optional: true
  )

  has_and_belongs_to_many(
    :users,
    -> { where(orphaned: false).order(:full_name) }
  )

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

  def self.find_by_clp(clp)
    find_by(**split_license_number(clp))
  end

  def self.clp(license_type, license_number)
    "#{license_type}#{license_number}"
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
