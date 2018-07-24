# frozen_string_literal: true

class UpdateLicenses < ActiveRecord::Migration[5.2]
  def change
    change_table :licenses do |t|
      t.references :location, foreign_key: true, index: true
      t.references :vendor, foreign_key: true, index: true
    end

    change_column_null :licenses, :license_number, true
    change_column_null :licenses, :user_id, true
  end
end
