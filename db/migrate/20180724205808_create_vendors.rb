# frozen_string_literal: true

class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.references :company, foreign_key: true, index: true
      t.string :owner_id, null: false
      t.string :license_number, null: false, index: { unique: true }
      t.string :name, null: false
      t.text :address1, null: false
      t.text :address2
      t.text :address3
      t.string :city, null: false
      t.string :county
      t.string :state
      t.string :country, null: false
      t.string :postal_code, null: false
      t.string :subordinate
      t.string :related_to
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
