# frozen_string_literal: true

class Setting < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.server_status
    @server_status ||= find_by(name: :server_status)
  end

  def self.server_status=(value)
    server_status.update!(value: value)
  end

  def self.server_active?
    server_status.value.to_sym == :active
  end

  def self.deactivate_server!
    self.server_status = :inactive
  end

  def self.activate_server!
    self.server_status = :active
  end
end
