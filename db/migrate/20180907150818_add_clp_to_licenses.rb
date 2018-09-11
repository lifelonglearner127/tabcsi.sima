# frozen_string_literal: true

class AddClpToLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :licenses, :clp, :string
  end
end
