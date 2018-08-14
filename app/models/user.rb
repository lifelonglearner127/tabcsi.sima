# frozen_string_literal: true

class User < ApplicationRecord
  PIN_CHARS = [*'0'..'9'].freeze
  PIN_LENGTH = 8

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
  has_many :inspections, -> { order(:id) }, dependent: :destroy

  has_and_belongs_to_many(
    :licenses,
    -> { order(:license_type, :license_number) }
  )

  has_and_belongs_to_many :locations, -> { order(:id) }
  has_many :push_tokens, -> { order(:id) }, dependent: :destroy

  before_validation :generate_random_password, if: :generate_password?

  attr_accessor :company_name
  attr_accessor :license_number

  def self.new_pin
    # based on SecureRandom.alphanumeric
    SecureRandom.__send__(:choose, PIN_CHARS, PIN_LENGTH)
  end

  def generate_pin
    pin = self.class.new_pin

    return nil unless update(password: pin)

    pin
  end

  def save_admin
    license = License.find_by_clp(license_number)

    return false if license.blank? || license.company.owned?

    self.company = license.company

    result = false
    transaction do
      license.company.update!(name: company_name, owned: true)

      result = save!
    end

    if result
      locations << company.locations
      licenses << company.licenses
    end

    result
  rescue ActiveRecord::RecordInvalid
    false
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
end
