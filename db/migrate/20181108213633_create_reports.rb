# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.boolean :include_received, null: false
      t.string :fiscal_year, null: false
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
