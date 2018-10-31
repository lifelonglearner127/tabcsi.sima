# frozen_string_literal: true

class AddOrphanColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.boolean :orphaned, default: false, null: false
      t.datetime :orphaned_at
      t.index :orphaned
    end
  end
end
