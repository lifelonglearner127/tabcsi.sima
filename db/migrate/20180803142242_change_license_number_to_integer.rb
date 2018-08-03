# frozen_string_literal: true

class ChangeLicenseNumberToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column(
      :licenses, :license_number, :integer, using: 'license_number::integer'
    )
  end
end
