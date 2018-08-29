# frozen_string_literal: true

class AddNullConstraintsToAnswersAndInspections < ActiveRecord::Migration[5.2]
  def change
    change_column_null :answers, :question_id, false
    change_column_null :inspections, :audit_form_id, false
  end
end
