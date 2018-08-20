# frozen_string_literal: true

class AddReportNumberToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :report_number, :string
  end
end
