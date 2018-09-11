# frozen_string_literal: true

class AddItemSubtypeToVersions < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :item_subtype, :string
  end
end
