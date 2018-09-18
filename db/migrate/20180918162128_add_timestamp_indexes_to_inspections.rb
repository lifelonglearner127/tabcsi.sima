# frozen_string_literal: true

class AddTimestampIndexesToInspections < ActiveRecord::Migration[5.2]
  def change
    change_table :inspections do |t|
      t.index :completed_at
      t.index :submitted_at
      t.index %i[completed_at submitted_at invalid]
    end
  end
end
