# frozen_string_literal: true

class RenameLicenseStatusToStatusOnLicenses < ActiveRecord::Migration[5.2]
  def change
    rename_column :licenses, :license_status, :status
  end
end
