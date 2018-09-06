# frozen_string_literal: true

class AddPinLastRequestedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pin_last_requested_at, :datetime
  end
end
