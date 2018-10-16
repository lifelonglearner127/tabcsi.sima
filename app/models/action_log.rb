# frozen_string_literal: true

class ActionLog < ApplicationRecord
  def self.sequence_id
    SecureRandom.hex(4)
  end
end
