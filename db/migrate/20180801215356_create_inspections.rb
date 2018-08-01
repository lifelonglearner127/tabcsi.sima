# frozen_string_literal: true

class CreateInspections < ActiveRecord::Migration[5.2]
  def change
    create_table :inspections do |t|
      t.references :location, null: false, foreign_key: true, index: true
      t.references :audit_form, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.datetime :started_at, null: false
      t.datetime :completed_at

      t.timestamps
    end
  end
end
