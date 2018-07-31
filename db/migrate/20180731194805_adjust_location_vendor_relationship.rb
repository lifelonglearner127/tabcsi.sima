# frozen_string_literal: true

class AdjustLocationVendorRelationship < ActiveRecord::Migration[5.2]
  def change
    remove_reference(
      :locations, :vendor, null: false, foreign_key: true, index: true
    )

    add_reference(
      :vendors, :location, null: false, foreign_key: true, index: true
    )
  end
end
