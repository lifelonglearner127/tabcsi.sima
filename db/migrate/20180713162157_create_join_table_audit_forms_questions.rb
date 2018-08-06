# frozen_string_literal: true

class CreateJoinTableAuditFormsQuestions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :audit_forms, :questions do |t|
      t.index %i[audit_form_id question_id], unique: true
      t.index %i[question_id audit_form_id], unique: true
    end
  end
end
