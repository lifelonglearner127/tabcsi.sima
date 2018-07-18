# frozen_string_literal: true

class AllowForeignKeyIdToBeNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :version_associations, :foreign_key_id, true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
