# frozen_string_literal: true

class Setting < ApplicationRecord
  DEFAULTS = {
    business_point_radius: 100, # feet
    server_status: :active,
    forms_build_date: Time.new(2018).strftime('%F'),
    fiscal_year: 2019,
    fiscal_year_start_day: 1,
    fiscal_year_start_month: 10,
    pin_length: 8,
    pin_expiration: 30.minutes,
    tabc_contact_url: 'https://www.tabc.texas.gov/CRHelpForm'
  }.freeze

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

  def self.fiscal_year_start_day
    by_name(:fiscal_year_start_day).value.to_i
  end

  def self.fiscal_year_start_month
    by_name(:fiscal_year_start_month).value.to_i
  end

  def self.pin_length
    by_name(:pin_length).value.to_i
  end

  def self.pin_expiration
    by_name(:pin_expiration).value.to_i
  end

  def self.tabc_contact_url
    by_name(:tabc_contact_url).value
  end
end
