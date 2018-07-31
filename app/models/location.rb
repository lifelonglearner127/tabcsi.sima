# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company
  has_many :licenses
  has_many_attached :photos
  has_and_belongs_to_many :users

  validates :name, :address1, :city, :country, :postal_code, presence: true
end
