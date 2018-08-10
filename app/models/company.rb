# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses, -> { order(:license_type, :license_number) }
  has_many :locations, -> { order(:id) }
  has_many :users, -> { order(:id) }

  validates :owner_name, presence: true, uniqueness: { case_sensitive: false }
end
