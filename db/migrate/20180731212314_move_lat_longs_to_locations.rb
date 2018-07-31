# frozen_string_literal: true

class MoveLatLongsToLocations < ActiveRecord::Migration[5.2]
  def change
    change_table :licenses do |t|
      t.remove :front_lat
      t.remove :front_long
      t.remove :back_lat
      t.remove :back_long
    end

    change_table :locations do |t|
      t.decimal :front_lat
      t.decimal :front_long
      t.decimal :back_lat
      t.decimal :back_long
    end
  end
end
