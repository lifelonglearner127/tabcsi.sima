# frozen_string_literal: true

class AddMultipleToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :multiple, :boolean, default: false, null: false
  end
end
