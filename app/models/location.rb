# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company
  has_many :licenses
  belongs_to :vendor
end
