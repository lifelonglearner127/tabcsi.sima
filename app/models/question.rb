# frozen_string_literal: true

class Question < ApplicationRecord
  has_and_belongs_to_many :audit_forms

  validates :question_id, :question_text, :question_type, presence: true
  validates :question_id, uniqueness: { case_sensitive: false }

  enum :question_type, %i[text_box radio]
end
