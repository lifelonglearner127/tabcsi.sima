# frozen_string_literal: true

Rails.application.configure do
  config.action_controller.perform_caching = true
  config.action_mailer.delivery_method = :aws_sdk
  config.action_mailer.perform_caching = false
  config.active_record.dump_schema_after_migration = false
  config.active_storage.service = :production
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
  config.log_tags = [->(request) { request.uuid[0, 8] }]

  config.logger =
    if Nenv.instance.rails_log_to_stdout?
      TabcSi.create_logger(ActiveSupport::Logger.new(STDOUT))
    else
      TabcSi.create_logger(config.paths['log'].first)
    end

  config.public_file_server.enabled = Nenv.instance.rails_serve_static_files?

  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31557600'
  }

  config.ssl_options = {
    hsts: {
      expires: 365.days,
      preload: false,
      subdomains: true
    },
    redirect: false,
    secure_cookies: true
  }

  config.webpacker.check_yarn_integrity = false

  config.middleware.use(Rack::Deflater)
end
