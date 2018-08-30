# frozen_string_literal: true

class AddAdditionalColumnsToQuestions < ActiveRecord::Migration[5.2]
  def change
    change_table :questions do |t|
      t.string :label
      t.string :additional_label
      t.integer :additional_text
      t.integer :additional_type
    end
  end
end
