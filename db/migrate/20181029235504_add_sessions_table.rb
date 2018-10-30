# frozen_string_literal: true

class AddSessionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :session_id, null: false, index: { unique: true }
      t.text :data
      t.timestamps
      t.index :updated_at
    end
  end
end
