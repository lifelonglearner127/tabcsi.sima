# frozen_string_literal: true

class AddCancellationReasonToInspections < ActiveRecord::Migration[5.2]
  def change
    change_table :inspections do |t|
      t.text :cancellation_reason
      t.datetime :cancelled_at
    end
  end
end
