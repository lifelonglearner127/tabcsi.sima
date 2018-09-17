# frozen_string_literal: true

class CreateQuestionHelpItems < ActiveRecord::Migration[5.2]
  def change
    create_table :question_help_items do |t|
      t.references :parent, null: false, polymorphic: true, index: true
      t.text :value, null: false
      t.integer :sort_order, null: false
      t.datetime :discarded_at

      t.timestamps
    end
  end
end
