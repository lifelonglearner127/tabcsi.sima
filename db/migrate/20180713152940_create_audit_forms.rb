# frozen_string_literal: true

class CreateAuditForms < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_forms do |t|
      t.string :permit_name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
