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
    foreign_key: :resource_owner_id
  )

  has_many(
    :access_tokens,
    class_name: 'Doorkeeper::AccessToken',
    foreign_key: :resource_owner_id
  )

  belongs_to :company
  has_and_belongs_to_many :licenses
  has_and_belongs_to_many :locations
  has_many :push_tokens

  def generate_pin
    pin = self.class.new_pin

    update(password: pin)

    pin
  end

  def self.new_pin
    # based on SecureRandom.alphanumeric
    SecureRandom.__send__(:choose, PIN_CHARS, PIN_LENGTH)
  end
end
