# frozen_string_literal: true

require_relative 'application'

Rails.application.initialize!

Rails.application.default_url_options =
  Rails.application.config.action_mailer.default_url_options
