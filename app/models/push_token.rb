# frozen_string_literal: true

class PushToken < ApplicationRecord
  belongs_to :user

  validates :user, :device_type, :token, presence: true
  validates :token, uniqueness: { scope: :user, case_sensitive: false }

  enum device_type: %i[android ios]
end
