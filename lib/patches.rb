# frozen_string_literal: true

require_relative 'railties/application'
require_relative 'webpacker/configuration'
require_relative 'devise-doorkeeper/devise/strategies/doorkeeper'
require_relative 'grape/request'

require_relative 'faker/name' if Rails.env.development? || Rails.env.test?
