# frozen_string_literal: true

class CreateJoinTableLicensesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :licenses, :users do |t|
      t.index %i[license_id user_id]
      t.index %i[user_id license_id]
    end
  end
end
