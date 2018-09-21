# frozen_string_literal: true

class User < ApplicationRecord
  PIN_CHARS = [*'0'..'9'].freeze

  devise(
    :database_authenticatable,
    :doorkeeper,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
  )

  has_many(
    :access_grants,
    class_name: 'Doorkeeper::AccessGrant',
    foreign_key: :resource_owner_id,
    dependent: :destroy
  )

  has_many(
    :access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id,
    dependent: :destroy
  )

  belongs_to :company, optional: true
  has_many :inspections, -> { order(:created_at) }, dependent: :destroy

  has_and_belongs_to_many(
    :licenses,
    -> { order(:license_type, :license_number) }
  )

  has_and_belongs_to_many :locations, -> { order(:name) }
  has_many :push_tokens, -> { order(created_at: :desc) }, dependent: :destroy

  enum role: %i[user admin tabc]

  before_validation :generate_random_password, if: :generate_password?
  after_initialize :set_default_role, if: :new_record?

  attr_accessor :company_name
  attr_accessor :is_invite
  attr_accessor :license_number
  attr_accessor :owner_name
  attr_accessor :is_profile

  def self.new_pin
    # based on SecureRandom.alphanumeric
    SecureRandom.__send__(:choose, PIN_CHARS, Setting.pin_length)
  end

  def generate_pin
    pin = self.class.new_pin

    unless update(password: pin, pin_last_requested_at: Time.zone.now)
      return nil
    end

    pin
  end

  def info
    {
      full_name: full_name,
      role: role,
      locations: locations.includes(:licenses).as_json(include: :licenses)
    }
  end

  def invite?
    is_invite
  end

  def profile?
    is_profile
  end

  def pin_current?
    !pin_expired?
  end

  def pin_expired?
    pin_last_requested_at.blank? ||
      Time.zone.now >= pin_last_requested_at + Setting.pin_expiration
  end

  def request_pin
    pin = generate_pin

    return false if pin.blank?

    UsersMailer.with(
      recipient: email,
      pin: pin
    ).request_pin.deliver_now

    true
  end

  def save_user
    license = nil

    if invite?
      company = Company.find_by(owner_name: owner_name)

      return false if company.blank?

      self.company = company
      self.role = :user
    else
      license = License.find_by_clp(license_number)

      return false if license.blank? || license.company.owned?

      self.company = license.company
    end

    result = false
    transaction do
      license.company.update!(name: company_name, owned: true) unless invite?

      result = save!
    end

    if result && !invite?
      locations << self.company.locations
      licenses << self.company.licenses
    end

    welcome_params = {
      recipient: email,
      full_name: full_name
    }

    if invite?
      welcome_params[:company_name] =
        self.company.name || self.company.owner_name
    end

    UsersMailer.with(**welcome_params).welcome.deliver_now

    result
  rescue ActiveRecord::RecordInvalid
    false
  end

  def valid_password?(password)
    pin_current? && super
  end

  def valid_pin?(pin)
    valid_for_authentication? { valid_password?(pin) }
  end

  private

  def generate_password?
    !persisted? && password.blank?
  end

  def generate_random_password
    self.password = SecureRandom.hex
  end

  def set_default_role
    self.role ||= :user
  end
end
