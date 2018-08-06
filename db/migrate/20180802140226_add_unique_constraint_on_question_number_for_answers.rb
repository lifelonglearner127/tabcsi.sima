# frozen_string_literal: true

class AddUniqueConstraintOnQuestionNumberForAnswers < ActiveRecord::Migration[5.2] # rubocop:disable Metrics/LineLength
  def change
    add_index :answers, %i[inspection_id question_number], unique: true
  end
end
