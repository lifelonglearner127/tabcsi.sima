# frozen_string_literal: true

class License < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
end
