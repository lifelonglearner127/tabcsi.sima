# frozen_string_literal: true

# This migration creates the `versions` table, the only schema PT requires. All
# other migrations PT provides are optional.
class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.references :item, null: false, polymorphic: true, index: true
      # t.string :item_type, null: false
      # t.integer :item_id, null: false
      t.string :event, null: false
      t.string :whodunnit
      t.text :object
      t.datetime :created_at, null: false

      # t.index %i[item_type item_id]
    end
  end
end
