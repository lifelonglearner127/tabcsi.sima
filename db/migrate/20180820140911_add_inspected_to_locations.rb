# frozen_string_literal: true

class AddInspectedToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :inspected, :boolean, default: false, null: false
  end
end
