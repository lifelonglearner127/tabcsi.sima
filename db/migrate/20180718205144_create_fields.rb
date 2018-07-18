# frozen_string_literal: true

class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.references :choice, null: false, foreign_key: true, index: true
      t.string :label, null: false
      t.integer :field_type, default: 0, null: false
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
