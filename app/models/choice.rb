# frozen_string_literal: true

class Choice < ApplicationRecord
  include LastUpdatable

  has_many :fields, -> { order(id: :asc) }
  belongs_to :question

  validates :choice_text, presence: true

  last_updated_by :fields
end
