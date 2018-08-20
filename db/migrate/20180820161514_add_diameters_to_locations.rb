# frozen_string_literal: true

class AddDiametersToLocations < ActiveRecord::Migration[5.2]
  def change
    change_table :locations do |t|
      t.decimal :unpadded_diameter
      t.decimal :padded_diameter
    end
  end
end
