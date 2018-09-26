# frozen_string_literal: true

class AddIndexToClpForLicenses < ActiveRecord::Migration[5.2]
  def change
    add_index :licenses, :clp, unique: true
  end
end
