# frozen_string_literal: true

class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :license_number, null: false, index: true
      t.decimal :front_lat, null: false
      t.decimal :front_long, null: false
      t.decimal :back_lat, null: false
      t.decimal :back_long, null: false

      t.timestamps
    end
  end
end
