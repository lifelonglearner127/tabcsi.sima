class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :company, null: false, foreign_key: true, index: true
      t.references :vendor, null: false, foreign_key: true, index: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
