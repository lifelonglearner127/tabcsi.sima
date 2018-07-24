# frozen_string_literal: true

class License < ApplicationRecord
  belongs_to :company
  belongs_to :location
  has_many_attached :photos
  belongs_to :vendor
end
