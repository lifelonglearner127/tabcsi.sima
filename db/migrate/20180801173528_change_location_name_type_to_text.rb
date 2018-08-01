# frozen_string_literal: true

class ChangeLocationNameTypeToText < ActiveRecord::Migration[5.2]
  def up
    change_column :locations, :name, :text
  end

  def down
    change_column :locations, :name, :string
  end
end
