# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module TabcSi
  class Api < Grape::API
    use(
      GrapeLogging::Middleware::RequestLogger,
      logger: logger,
      formatter: GrapeLogging::Formatters::Rails.new
    )

    helpers Doorkeeper::Grape::Helpers
    helpers TabcSi::Helpers::General
    helpers TabcSi::Helpers::Errors

    default_format :json
    format :json
    content_type :json, 'application/json'

    rescue_from TabcSi::Error do |error|
      error! error.message, error.code
    end

    before do
      if request.path.end_with? '/docs_spec'
        # restrict access to allowed IP addresses
        error_not_found! unless AllowedIpConstraint.new.matches?(request)
      else
        doorkeeper_authorize!
      end
    end

    mount V1Api
  end
end
