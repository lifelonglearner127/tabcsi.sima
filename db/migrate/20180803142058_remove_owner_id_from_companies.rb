# frozen_string_literal: true

class RemoveOwnerIdFromCompanies < ActiveRecord::Migration[5.2]
  def change
    change_table :companies do |t|
      t.remove :owner_id
      t.index :owner_name, unique: true
    end
  end
end
