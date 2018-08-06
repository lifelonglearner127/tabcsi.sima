# frozen_string_literal: true

class AddFinishedAtAndSubmittedAtToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :finished_at, :datetime
    add_column :inspections, :submitted_at, :datetime
  end
end
