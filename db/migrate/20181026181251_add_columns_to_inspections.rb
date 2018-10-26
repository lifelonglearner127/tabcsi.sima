# frozen_string_literal: true

class AddColumnsToInspections < ActiveRecord::Migration[5.2]
  def change
    change_table :inspections do |t|
      t.boolean :flagged
      t.text :flag_reason
      t.datetime :flagged_at

      t.index :flagged
    end
  end
end
