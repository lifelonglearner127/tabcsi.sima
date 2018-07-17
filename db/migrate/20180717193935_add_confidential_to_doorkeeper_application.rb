# frozen_string_literal: true

class AddConfidentialToDoorkeeperApplication < ActiveRecord::Migration[5.2]
  def change
    add_column(
      :oauth_applications,
      :confidential,
      :boolean,
      # maintaining backwards compatibility: require secrets
      default: true,
      null: false
    )
  end
end
