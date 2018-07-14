# frozen_string_literal: true

class Choice < ApplicationRecord
  belongs_to :question

  validates :question, :choice_text, presence: true
end
