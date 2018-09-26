# frozen_string_literal: true

class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :news_type, default: 0, null: false, index: true
      t.string :subject, null: false
      t.text :content, null: false
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
