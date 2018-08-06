# frozen_string_literal: true

class RenameQuestionIdToQuestionNumberForQuestions < ActiveRecord::Migration[5.2] # rubocop:disable Metrics/LineLength
  def change
    rename_column :questions, :question_id, :question_number
  end
end
