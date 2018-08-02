# frozen_string_literal: true

class AddLicenseStatusAndExpiresOnToLicenses < ActiveRecord::Migration[5.2]
  def change
    change_table :licenses do |t|
      t.string :license_status, null: false
      t.date :expires_on
    end
  end
end
