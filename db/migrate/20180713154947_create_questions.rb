# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question_id, null: false
      t.text :question_text, null: false
      t.integer :question_type, null: false
      t.integer :max_characters, default: 0, null: false
      t.boolean :multiline, default: false, null: false

      t.timestamps
    end
  end
end
