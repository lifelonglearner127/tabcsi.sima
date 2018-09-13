# frozen_string_literal: true

class DropPaperTrailTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :version_associations
    drop_table :versions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
