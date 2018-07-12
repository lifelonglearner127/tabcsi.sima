class CreatePushTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :push_tokens do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :device_type, null: false
      t.text :token, null: false

      t.timestamps
    end

    add_index :push_tokens, %i[user_id device_type], unique: true
  end
end
