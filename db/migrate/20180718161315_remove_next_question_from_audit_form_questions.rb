# frozen_string_literal: true

class RemoveNextQuestionFromAuditFormQuestions < ActiveRecord::Migration[5.2]
  def up
    remove_column :audit_form_questions, :next_question
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
