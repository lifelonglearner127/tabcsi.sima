class AddInspectedByIdToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :inspected_by_id, :bigint
  end
end
