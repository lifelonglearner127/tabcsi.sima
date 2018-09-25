# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses, -> { order(:clp) }
  has_many :locations, -> { order(:name, :clp) }
  has_many :users, -> { order(:full_name) }

  validates :owner_name, presence: true, uniqueness: { case_sensitive: false }
end
