# frozen_string_literal: true

require_relative '../smtp'

APPLICATION_HOST = ENV.fetch('APPLICATION_HOST')

if ENV.fetch('HEROKU_APP_NAME', '').include?('staging-pr-')
  HEROKU_APPLICATION_HOST = ENV['HEROKU_APP_NAME'] + '.herokuapp.com'
else
  HEROKU_APPLICATION_HOST = APPLICATION_HOST
end

ASSET_HOST = ENV.fetch('ASSET_HOST', APPLICATION_HOST)
MAILER_ASSET_HOST = ENV.fetch('ASSET_HOST', HEROKU_APPLICATION_HOST)

Rails.application.configure do
  config.action_controller.asset_host = ASSET_HOST
  config.action_controller.perform_caching = true
  config.action_mailer.asset_host = MAILER_ASSET_HOST
  config.action_mailer.default_url_options = { host: HEROKU_APPLICATION_HOST }
  config.action_mailer.perform_caching = false
  config.active_record.dump_schema_after_migration = false
  config.active_storage.service = :local
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.js_compressor = :uglifier
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.force_ssl = true
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :debug
  config.log_tags = %i[request_id]
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31557600'
  }

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.middleware.use(Rack::CanonicalHost, HEROKU_APPLICATION_HOST)
  config.middleware.use(Rack::Deflater)
end

Rack::Timeout.timeout = ENV.fetch('RACK_TIMEOUT', 10).to_i
