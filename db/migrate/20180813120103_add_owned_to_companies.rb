# frozen_string_literal: true

class AddOwnedToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :owned, :boolean, default: false, null: false
  end
end
