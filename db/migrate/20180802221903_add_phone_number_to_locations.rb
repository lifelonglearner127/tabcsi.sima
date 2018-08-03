# frozen_string_literal: true

class AddPhoneNumberToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :phone_number, :string
  end
end
