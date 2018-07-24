# frozen_string_literal: true

class License < ApplicationRecord
  belongs_to :company
  has_many_attached :photos
  belongs_to :user
end
