# frozen_string_literal: true

class AddLicenseTypeToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :license_type, :string, null: false
    add_index :vendors, %i[license_type license_number], unique: true
    remove_index :vendors, :license_number
  end
end
