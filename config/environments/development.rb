# frozen_string_literal: true

APPLICATION_HOST = Nenv.instance.application_host

Rails.application.configure do
  config.action_mailer.asset_host = APPLICATION_HOST
  config.action_mailer.default_url_options = { host: APPLICATION_HOST }
  config.action_mailer.delivery_method = :file
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_view.raise_on_missing_translations = true
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_storage.service = :local
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.assets.quiet = true
  config.cache_classes = false
  config.consider_all_requests_local = true
  config.eager_load = false
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.webpacker.check_yarn_integrity = true

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {}
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.rails_logger = true
  end
end
