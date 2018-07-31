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
    helpers TabcSi::Helpers::Response

    default_format :json
    format :json
    content_type :json, 'application/json'

    default_error_status 400
    error_formatter :json, Formatters::Error
    default_error_formatter :json

    formatter :json, Formatters::Success

    rescue_from :all do |error|
      log_error =
        case error
        when ActiveRecord::RecordNotFound,
             Grape::Exceptions::ValidationErrors,
             TabcSi::Error
          false
        else
          true
        end

      status =
        case error
        when ActiveRecord::RecordNotFound
          404
        else
          (error.respond_to?(:status) && error.status) || 500
        end

      code = (error.respond_to?(:code) && error.code) || status

      if log_error
        logger.error "#{error.class} (#{error.message}):"

        clean_backtrace(error).each do |line|
          logger.error "  #{line}"
        end

        logger.error ''
      end

      if status == 500
        message = 'internal server error'
        messages = [{ title: message, detail: message }]
      elsif error.is_a?(Grape::Exceptions::ValidationErrors)
        error_map =
          error.map do |attributes, inner_error|
            obj = {
              title: inner_error.message,
              detail: error.__send__(:full_message, attributes, inner_error)
            }

            if attributes.size == 1
              obj[:source] = { parameter: attributes.first }
            end

            obj
          end

        messages = error_map.uniq
      else
        message = error.message
        title = error.respond_to?(:title) ? error.title : message
        detail = error.respond_to?(:detail) ? error.detail : message
        messages = [{ title: title, detail: detail }]
      end

      errors =
        messages.map do |msg|
          create_error_object(
            status: status,
            code: code,
            title: msg[:title],
            detail: msg[:detail],
            source: msg[:source]
          )
        end

      error! errors, status
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
