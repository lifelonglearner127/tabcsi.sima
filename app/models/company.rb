# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses, -> { order(:license_type, :license_number) }
  has_many :locations, -> { includes(:licenses).order(:name) }
  has_many :users, -> { order(:full_name) }

  validates :owner_name, presence: true, uniqueness: { case_sensitive: false }
end
