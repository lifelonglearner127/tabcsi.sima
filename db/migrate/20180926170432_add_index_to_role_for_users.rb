# frozen_string_literal: true

class AddIndexToRoleForUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :role
  end
end
