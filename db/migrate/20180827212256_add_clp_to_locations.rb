# frozen_string_literal: true

class AddClpToLocations < ActiveRecord::Migration[5.2]
  def change
    change_table :locations do |t|
      t.string :clp
      t.index :clp, unique: true
    end
  end
end
