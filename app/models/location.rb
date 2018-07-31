# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company
  has_many :licenses
  has_and_belongs_to_many :users
  has_many :vendors

  def location_info
    vendors.first
  end

  delegate(
    :address1, :address2, :address3, :city, :country, :county, :name,
    :postal_code, :state,
    to: :location_info
  )
end
