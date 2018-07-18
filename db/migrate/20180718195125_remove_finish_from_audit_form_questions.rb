# frozen_string_literal: true

class RemoveFinishFromAuditFormQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column(
      :audit_form_questions, :finish, :boolean, default: false, null: false
    )
  end
end
