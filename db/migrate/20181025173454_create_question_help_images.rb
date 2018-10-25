# frozen_string_literal: true

class CreateQuestionHelpImages < ActiveRecord::Migration[5.2]
  def change
    create_table :question_help_images do |t|
      t.references :parent, null: false, polymorphic: true, index: true
      t.string :path, null: false
      t.integer :sort_order, null: false, index: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
