# frozen_string_literal: true

class CreateVersionAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :version_associations do |t|
      t.references :version, null: false, foreign_key: true, index: true
      t.string :foreign_key_name, null: false
      t.references :foreign_key, null: false

      t.index(
        %i[foreign_key_name foreign_key_id],
        name: 'index_version_associations_on_foreign_key'
      )
    end
  end
end
