# frozen_string_literal: true

class AddSourceAndOtherToQuestions < ActiveRecord::Migration[5.2]
  def change
    change_table :questions do |t|
      t.text :source
      t.integer :other
    end
  end
end
