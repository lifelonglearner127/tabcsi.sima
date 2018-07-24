# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses
  has_many :locations
  has_many :users
  has_many :vendors

  validates :name, presence: true
end
