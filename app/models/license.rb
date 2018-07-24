# frozen_string_literal: true

class License < ApplicationRecord
  belongs_to :company
  belongs_to :location
  has_many_attached :photos
  has_and_belongs_to_many :users
  belongs_to :vendor
end
