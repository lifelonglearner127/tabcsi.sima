# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :company
  belongs_to :vendor
end
