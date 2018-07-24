# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.text :name, null: false
      t.datetime :discarded_at, index: true

      t.timestamps
    end

    add_reference :licenses, :company, foreign_key: true, index: true
    add_reference :users, :company, foreign_key: true, index: true
  end
end
