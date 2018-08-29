# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :inspection
  has_many_attached :pictures
  belongs_to :question

  validates :question, uniqueness: { scope: :inspection }
end
