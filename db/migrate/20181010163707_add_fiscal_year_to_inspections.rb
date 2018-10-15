# frozen_string_literal: true

class AddFiscalYearToInspections < ActiveRecord::Migration[5.2]
  def up
    add_column :inspections, :fiscal_year, :string
    add_index :inspections, :fiscal_year
  end

  def down
    remove_column :inspections, :fiscal_year
  end
end
