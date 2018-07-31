# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses
  has_many :locations
  has_many :users

  validates :owner_id, presence: true, uniqueness: { case_sensitive: false }
end
