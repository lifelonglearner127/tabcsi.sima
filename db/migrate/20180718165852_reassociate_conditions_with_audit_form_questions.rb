# frozen_string_literal: true

class ReassociateConditionsWithAuditFormQuestions < ActiveRecord::Migration[5.2]
  def up
    add_reference(
      :conditions, :audit_form_question, foreign_key: true, index: true
    )

    change_column_null :conditions, :question_id, true
    change_column_null :conditions, :audit_form_question_id, false
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
