# frozen_string_literal: true

class AddConditionalQuestionNumberToConditions < ActiveRecord::Migration[5.2]
  def change
    add_column :conditions, :conditional_question_number, :string, null: false
  end
end
