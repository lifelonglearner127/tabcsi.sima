# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

Oj.optimize_rails

require_relative '../lib/patches'

module Web
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    config.load_defaults 5.2

    config.action_controller.action_on_unpermitted_parameters = :raise

    config.action_mailer.default_url_options = {
      protocol: Nenv.instance.application_protocol,
      host: Nenv.instance.application_host,
      port: Nenv.instance.port
    }

    config.active_job.queue_adapter = :delayed_job
    config.assets.quiet = true

    config.generators do |generate|
      generate.helper false
      generate.javascripts false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end

    config.generators.system_tests = nil

    config.middleware.use Rack::Attack
  end
end
