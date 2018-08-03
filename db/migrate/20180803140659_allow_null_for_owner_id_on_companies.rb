# frozen_string_literal: true

class AllowNullForOwnerIdOnCompanies < ActiveRecord::Migration[5.2]
  def change
    change_column_null :companies, :owner_id, true
  end
end
