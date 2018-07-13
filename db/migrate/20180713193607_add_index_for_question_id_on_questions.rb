# frozen_string_literal: true

class AddIndexForQuestionIdOnQuestions < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :question_id, unique: true
  end
end
