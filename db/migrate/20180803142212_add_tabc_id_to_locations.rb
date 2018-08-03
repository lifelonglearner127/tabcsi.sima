# frozen_string_literal: true

class AddTabcIdToLocations < ActiveRecord::Migration[5.2]
  def change
    change_table :locations do |t|
      t.integer :tabc_id
      t.index :tabc_id, unique: true
    end
  end
end
