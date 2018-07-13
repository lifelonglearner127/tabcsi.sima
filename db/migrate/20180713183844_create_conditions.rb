# frozen_string_literal: true

class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.references :question, null: false, foreign_key: true, index: true
      t.string :condition_value, null: false

      t.timestamps
    end
  end
end
