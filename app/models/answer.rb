# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :inspection
  belongs_to :question, optional: true

  validates :question, uniqueness: { scope: :inspection }
end
