# frozen_string_literal: true

class AddIndexesToQuestionHelpItems < ActiveRecord::Migration[5.2]
  def change
    change_table :question_help_items do |t|
      t.index :discarded_at
      t.index :sort_order
    end
  end
end
