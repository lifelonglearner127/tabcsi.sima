# frozen_string_literal: true

class Choice < ApplicationRecord
  has_many :fields
  belongs_to :question

  validates :choice_text, presence: true
end
