# frozen_string_literal: true

class RemoveFormUniqueConstraints < ActiveRecord::Migration[5.2]
  def change
    remove_index :audit_forms, column: :permit_name, unique: true

    change_table :audit_form_questions do |t|
      t.remove_index column: %i[audit_form_id question_id], unique: true
      t.remove_index column: %i[question_id audit_form_id], unique: true
    end

    remove_index :questions, column: :question_number, unique: true
  end
end
