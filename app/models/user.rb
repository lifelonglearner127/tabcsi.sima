# frozen_string_literal: true

class User < ApplicationRecord
  devise(
    :database_authenticatable,
    :jwt_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    jwt_revocation_strategy: JwtBlacklist
  )
end
