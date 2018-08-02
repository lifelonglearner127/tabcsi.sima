# frozen_string_literal: true

class ReassociateAnswersWithLocations < ActiveRecord::Migration[5.2]
  def up
    change_table :answers do |t|
      t.remove_references :question, foreign_key: true, index: true
      t.remove_index :license_number
      t.remove :license_number

      t.rename :answer_value, :value

      t.references :inspection, null: false, foreign_key: true, index: true
      t.string :question_number, null: false
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
