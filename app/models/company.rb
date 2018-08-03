# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses, -> { order(id: :asc) }
  has_many :locations, -> { order(id: :asc) }
  has_many :users, -> { order(id: :asc) }

  validates :owner_name, presence: true, uniqueness: { case_sensitive: false }
end
