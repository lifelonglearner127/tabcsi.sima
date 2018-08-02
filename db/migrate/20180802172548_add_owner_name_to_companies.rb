# frozen_string_literal: true

class AddOwnerNameToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :owner_name, :text, null: false
  end
end
