# frozen_string_literal: true

class AddIndexToDeviceTypeOfPushTokens < ActiveRecord::Migration[5.2]
  def change
    add_index :push_tokens, :device_type
  end
end
