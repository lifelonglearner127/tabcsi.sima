class AddFiscalYearToInspections < ActiveRecord::Migration[5.2]
  def up
    add_column :inspections, :fiscal_year, :string

    Inspection.find_each do |inspection|
      inspection.update!(fiscal_year: Setting.fiscal_year)
    end

    change_column_null :inspections, :fiscal_year, false
    add_index :inspections, :fiscal_year
  end

  def down
    remove_column :inspections, :fiscal_year
  end
end
