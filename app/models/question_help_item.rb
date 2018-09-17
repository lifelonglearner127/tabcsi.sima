# frozen_string_literal: true

class QuestionHelpItem < ApplicationRecord
  belongs_to :parent, polymorphic: true

  default_scope -> { order(:sort_order) }
end
