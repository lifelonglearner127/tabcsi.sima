# frozen_string_literal: true

class CreateJoinTableLocationsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :locations, :users do |t|
      t.index %i[location_id user_id]
      t.index %i[user_id location_id]
    end
  end
end
