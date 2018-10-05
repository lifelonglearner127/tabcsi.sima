# frozen_string_literal: true

class AddInspectedByIdToLocations < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :inspected_by, index: true
  end
end
