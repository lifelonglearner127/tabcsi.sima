# frozen_string_literal: true

class AddInvalidToInspections < ActiveRecord::Migration[5.2]
  def change
    change_table :inspections do |t|
      t.boolean :invalid, default: false, null: false
      t.index :invalid
    end
  end
end
