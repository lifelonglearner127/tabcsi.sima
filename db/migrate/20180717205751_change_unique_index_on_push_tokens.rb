# frozen_string_literal: true

class ChangeUniqueIndexOnPushTokens < ActiveRecord::Migration[5.2]
  def up
    remove_index :push_tokens, %i[user_id device_type]
    add_index :push_tokens, %i[user_id token], unique: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
