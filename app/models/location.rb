# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company
  has_many :licenses
  has_and_belongs_to_many :users
  belongs_to :vendor
end
