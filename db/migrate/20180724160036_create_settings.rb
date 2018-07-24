class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :value
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
