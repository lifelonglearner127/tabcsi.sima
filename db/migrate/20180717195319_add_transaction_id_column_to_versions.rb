# frozen_string_literal: true

class AddTransactionIdColumnToVersions < ActiveRecord::Migration[5.2]
  def change
    change_table :versions do |t|
      t.references :transaction, index: true
    end
  end
end
