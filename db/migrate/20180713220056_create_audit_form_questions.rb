# frozen_string_literal: true

class CreateAuditFormQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_table :audit_forms_questions, :audit_form_questions
    change_table :audit_form_questions do |t|
      t.primary_key :id
      t.string :next_question
      t.boolean :finish, default: false, null: false

      t.timestamps null: true
    end

    change_column_null :audit_form_questions, :created_at, false, Time.current
    change_column_null :audit_form_questions, :updated_at, false, Time.current

    add_foreign_key :audit_form_questions, :audit_forms
    add_foreign_key :audit_form_questions, :questions
  end
end
