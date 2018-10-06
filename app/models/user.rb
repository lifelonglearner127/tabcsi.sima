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
    -> { order(:clp) }
  )

  has_and_belongs_to_many :locations, -> { order(:name, :clp) }
  has_many :news, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :push_tokens, -> { order(created_at: :desc) }, dependent: :destroy

  enum role: %i[user admin tabc]

  before_validation :generate_random_password, if: :generate_password?
  after_initialize :set_default_role, if: :new_record?
  before_create :before_create_user
  after_create :after_create_user
  before_update :before_update_user, unless: :requested_pin?
  after_update :after_update_user, unless: :perform_after_update_user?

  attr_accessor :company_name
  attr_accessor :invited
  attr_accessor :license_number
  attr_writer :location_clps
  attr_accessor :owner_name
  attr_accessor :profile

  def self.new_pin
    # based on SecureRandom.alphanumeric
    SecureRandom.__send__(:choose, PIN_CHARS, Setting.pin_length)
  end

  def info
    {
      company_name: company_name || company&.name,
      email: email,
      full_name: full_name,
      id: id,
      job_title: job_title,
      license_number: license_number,
      locations: locations
        .includes(:licenses, :locked_by, :inspected_by)
        .as_json(include: %i[licenses locked_by inspected_by]),
      location_clps: location_clps,
      phone: phone,
      role: role,
      news: news
    }
  end

  def invited?
    [true, 'true'].include?(invited)
  end

  def location_clps
    @location_clps || locations.pluck(:clp) unless admin?
  end

  def pin_current?
    !pin_expired?
  end

  def pin_expired?
    pin_last_requested_at.blank? ||
      Time.zone.now >= pin_last_requested_at + Setting.pin_expiration
  end

  def request_pin
    @requested_pin = true

    pin = generate_pin

    return false if pin.blank?

    UsersMailer.with(
      recipient: email,
      full_name: full_name,
      pin: pin
    ).request_pin.deliver_now

    true
  end

  def revoke_access_tokens(application_id = nil)
    conditions = { revoked_at: nil }
    conditions[:application_id] = application_id if application_id.present?
    access_tokens.where(conditions).each(&:revoke)
  end

  def valid_password?(password)
    pin_current? && super
  end

  def valid_pin?(pin)
    valid_for_authentication? { valid_password?(pin) }
  end

  def locked_locations
    Location.where(locked: true, locked_by_id: id)
  end

  private

  def add_error(message)
    errors.add(:base, message)
  end

  def after_create_user
    if invited? && user?
      locations << Location.where(clp: location_clps)
      licenses << License.where(clp: location_clps)
    else # sign_up or admin invite
      locations << company.locations
      licenses << company.licenses
    end

    UsersMailer.with(
      recipient: email,
      full_name: full_name
    ).welcome.deliver_now
  end

  def after_update_user
    if user? || became_admin?
      locations.clear
      licenses.clear
    end

    if user?
      locations << Location.where(clp: location_clps)
      licenses << License.where(clp: location_clps)
    elsif became_admin?
      locations << company.locations
      licenses << company.licenses
    end
  end

  def became_admin?
    @became_admin
  end

  def before_create_user
    if invited?
      invitee = User.with_discarded.find_by(email: email)

      if invitee.present?
        if invitee.discarded_at.nil?
          add_error('User already exists. Please try another email address.')
        else
          add_error(
            'User was deleted. Please contact TABC to undelete the user.'
          )
        end

        throw :abort
      end

      company = Company.find_by(owner_name: owner_name)

      if company.blank?
        add_error('Company does not exist.')

        throw :abort
      end

      self.company = company
      self.role = :user if role.blank?

      return
    end

    license = License.find_by(clp: license_number)

    if license.blank?
      add_error('License does not exist.')

      throw :abort
    end

    if license.company.owned?
      add_error('Company has already been registered.')

      throw :abort
    end

    self.company_id = license.company.id

    license.company.update!(name: company_name, owned: true)
  end

  def before_update_user
    if email_changed?
      other = User.with_discarded.find_by(email: email)

      if other.present?
        add_error('User already exists. Please try another email address.')

        throw :abort
      end
    end

    @became_admin = role_changed?(from: 'user', to: 'admin')
  end

  def generate_password?
    !persisted? && password.blank?
  end

  def generate_pin
    pin = self.class.new_pin

    unless update(password: pin, pin_last_requested_at: Time.zone.now)
      return nil
    end

    pin
  end

  def generate_random_password
    self.password = SecureRandom.hex
  end

  def perform_after_update_user?
    requested_pin? || profile?
  end

  def profile?
    [true, 'true'].include?(profile)
  end

  def requested_pin?
    @requested_pin
  end

  def set_default_role
    self.role ||= :user
  end
end
