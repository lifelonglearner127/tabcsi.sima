# frozen_string_literal: true

class Setting < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end