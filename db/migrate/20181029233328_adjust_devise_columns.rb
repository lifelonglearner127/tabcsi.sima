# frozen_string_literal: true

class AdjustDeviseColumns < ActiveRecord::Migration[5.2]
  def up
    change_table :users do |t|
      ## Recoverable
      t.remove :reset_password_token
      t.remove :reset_password_sent_at

      ## Lockable
      t.integer :failed_attempts, default: 0, null: false
      t.datetime :locked_at
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
