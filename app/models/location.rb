# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company
  has_many :inspections, -> { order(:created_at) }
  has_many :licenses, -> { order(:license_type, :license_number) }
  belongs_to :locked_by, class_name: 'User', optional: true
  has_many_attached :photos
  has_and_belongs_to_many :users, -> { order(:full_name) }

  validates :name, :address1, :city, :country, :postal_code, presence: true
end
