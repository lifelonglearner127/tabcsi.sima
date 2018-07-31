# frozen_string_literal: true

class ConsolidateVendorsTable < ActiveRecord::Migration[5.2]
  def up
    change_column_null :companies, :name, true

    change_table :companies do |t|
      t.string :owner_id, null: false
      t.index :owner_id, unique: true
    end

    change_table :locations do |t|
      t.string :name, null: false
      t.text :address1, null: false
      t.text :address2
      t.text :address3
      t.string :city, null: false
      t.string :county
      t.string :state
      t.string :country, null: false
      t.string :postal_code, null: false
    end

    {
      company_id: false,
      location_id: false,
      license_number: false,
      front_lat: true,
      front_long: true,
      back_lat: true,
      back_long: true
    }.each do |column_name, null|
      change_column_null :licenses, column_name, null
    end

    change_table :licenses do |t|
      t.remove_references :user, foreign_key: true, index: true
      t.remove_references :vendor, foreign_key: true, index: true
      t.remove_index :license_number

      t.string :license_type, null: false
      t.string :subordinate
      t.string :related_to

      t.index %i[license_type license_number], unique: true
    end

    drop_table :vendors
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
