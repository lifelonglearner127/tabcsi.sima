# frozen_string_literal: true

class AddDiscardedAtToModels < ActiveRecord::Migration[5.2]
  TABLES = %i[
    answers audit_forms audit_form_questions choices conditions licenses
    push_tokens questions users
  ].freeze

  def up
    TABLES.each do |table_name|
      add_column table_name, :discarded_at, :datetime
      add_index table_name, %i[discarded_at]
    end
  end

  def down
    TABLES.each do |table_name|
      remove_index table_name, %i[discarded_at]
      remove_column table_name, :discarded_at
    end
  end
end
