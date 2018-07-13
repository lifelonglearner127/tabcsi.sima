# frozen_string_literal: true

class Question < ApplicationRecord
  has_and_belongs_to_many :audit_forms
  has_many :choices
  has_many :conditions

  validates :question_id, :question_text, :question_type, presence: true
  validates :question_id, uniqueness: { case_sensitive: false }

  enum question_type: %i[radio text_box]
end
