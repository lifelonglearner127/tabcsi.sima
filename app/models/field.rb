# frozen_string_literal: true

class Field < ApplicationRecord
  belongs_to :choice

  validates :label, :field_type, presence: true

  enum field_type: %i[time_range]
end
