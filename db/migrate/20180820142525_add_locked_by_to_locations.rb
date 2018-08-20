# frozen_string_literal: true

class AddLockedByToLocations < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :locked_by, index: true
  end
end
