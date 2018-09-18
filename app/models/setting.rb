# frozen_string_literal: true

class Setting < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.by_name(name)
    name = name.to_sym

    find_by(name: name)
  end

  def self.server_status=(value)
    by_name(:server_status).update!(value: value)
  end

  def self.server_active?
    by_name(:server_status).value.to_sym == :active
  end

  def self.deactivate_server!
    self.server_status = :inactive
  end

  def self.activate_server!
    self.server_status = :active
  end

  def self.forms_build_date
    value = by_name(:forms_build_date)&.value

    begin
      value.present? ? Date.strptime(value, '%F') : value
    rescue ArgumentError
      value
    end
  end

  def self.forms_build_date=(value)
    by_name(:forms_build_date).update!(value: value)
  end

  def self.fiscal_year
    by_name(:fiscal_year).value.to_i
  end

  def self.pin_length
    by_name(:pin_length).value.to_i
  end

  def self.pin_expiration
    by_name(:pin_expiration).value.to_i
  end
end
