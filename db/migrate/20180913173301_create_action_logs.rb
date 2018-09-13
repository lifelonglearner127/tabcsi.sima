# frozen_string_literal: true

class CreateActionLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :action_logs do |t|
      t.string :sequence_id, null: false
      t.string :tag, null: false
      t.text :message, null: false
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
