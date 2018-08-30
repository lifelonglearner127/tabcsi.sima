# frozen_string_literal: true

class AddLockedAtAndInspectedAtToLocations < ActiveRecord::Migration[5.2]
  def change
    change_table :locations do |t|
      t.datetime :locked_at
      t.datetime :inspected_at
    end
  end
end
