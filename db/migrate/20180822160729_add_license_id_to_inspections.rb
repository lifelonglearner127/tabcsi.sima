# frozen_string_literal: true

class AddLicenseIdToInspections < ActiveRecord::Migration[5.2]
  def change
    add_reference :inspections, :license, foreign_key: true, index: true
  end
end
