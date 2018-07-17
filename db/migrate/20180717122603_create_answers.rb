# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true, index: true
      t.string :license_number, null: false, index: true
      t.text :answer_value, null: false

      t.timestamps
    end
  end
end
