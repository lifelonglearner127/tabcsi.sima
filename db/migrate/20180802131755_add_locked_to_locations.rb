# frozen_string_literal: true

class AddLockedToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :locked, :boolean, default: false, null: false
  end
end
