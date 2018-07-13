# frozen_string_literal: true

class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.references :question, null: false, foreign_key: true, index: true
      t.string :choice_text, null: false
      t.boolean :picture_attachment, null: false

      t.timestamps
    end
  end
end
