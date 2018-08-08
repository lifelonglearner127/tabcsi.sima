# frozen_string_literal: true

class ChangesNeededForQuestionRebuilding < ActiveRecord::Migration[5.2]
  def up
    remove_index :answers, %i[inspection_id question_number]
    remove_column :answers, :question_number
    add_reference :answers, :question, foreign_key: true, index: true
    add_index :answers, %i[inspection_id question_id], unique: true

    change_column_null :inspections, :audit_form_id, true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
