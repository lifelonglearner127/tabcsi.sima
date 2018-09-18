# frozen_string_literal: true

class RenameInvalidToErroneousForInspections < ActiveRecord::Migration[5.2]
  def change
    change_table :inspections do |t|
      t.rename_index(
        'index_inspections_on_completed_at_and_submitted_at_and_invalid',
        'index_inspections_on_unsubmitted'
      )

      t.rename :invalid, :erroneous
    end
  end
end
