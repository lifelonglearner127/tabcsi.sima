# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company, -> { with_discarded }
  has_many :inspections, -> { order(:created_at) }
  has_many :licenses, -> { order(:clp) }

  belongs_to(
    :locked_by,
    -> { with_discarded },
    class_name: 'User',
    optional: true
  )

  belongs_to(
    :inspected_by,
    -> { with_discarded },
    class_name: 'User',
    optional: true
  )

  has_many_attached :photos

  has_and_belongs_to_many(
    :users,
    -> { where(orphaned: false).order(:full_name) }
  )

  validates :name, :address1, :city, :country, :postal_code, presence: true

  def reset(
    destroy_inspections: false,
    inspection: false,
    location: false,
    lock: false
  )
    attrs = {}

    if destroy_inspections
      inspections.where(fiscal_year: Setting.fiscal_year).destroy_all
    end

    if inspection
      attrs[:inspected] = false
      attrs[:inspected_at] = nil
    end

    if location
      attrs.merge!(
        front_lat: nil,
        front_long: nil,
        back_lat: nil,
        back_long: nil,
        unpadded_diameter: nil,
        padded_diameter: nil
      )
    end

    if lock
      attrs.merge!(
        locked: false,
        locked_by_id: nil,
        locked_at: nil
      )
    end

    update!(attrs) unless attrs.empty?
  end
end
