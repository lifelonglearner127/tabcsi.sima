# frozen_string_literal: true

module Api
  class BaseApiController < ActionController::API
    respond_to :json

    rescue_from StandardError do |e|
      raise e unless %r{^/api}.match?(request.env['ORIGINAL_FULLPATH'])

      unless e.is_a?(ApiError)
        error_data = nil

        case e
        when ActionController::ParameterMissing
          status = :fail
          error_data = { message: e.message }
          code = :unprocessable_entity
        else
          status = :error
          message = "#{e.class.name} : #{e.message}"
          error_data = { trace: e.backtrace } if Rails.env.development?
          code = :internal_server_error
        end

        e = ApiError.new(status, error_data, message, code)
      end

      render json: e.to_json, status: e.status_code
    end

    def current_resource_owner
      return nil unless doorkeeper_token&.resource_owner_id

      User.find(doorkeeper_token.resource_owner_id)
    end

    def current_application
      doorkeeper_token&.application
    end

    def success!(message_or_data)
      data =
        if message_or_data.is_a?(Hash)
          message_or_data
        else
          { message: message_or_data }
        end

      jsend!(:success, data)
    end

    def fail!(message_or_data, code = :bad_request)
      data =
        if message_or_data.is_a?(Hash)
          message_or_data
        else
          { message: message_or_data }
        end

      jsend!(:fail, data, code: code)
    end

    def error!(message, code: :internal_server_error, data: nil)
      jsend!(:error, data, message: message, code: code)
    end

    private

    def jsend!(status, data, message: nil, code: nil)
      raise ApiError.new(status, data, message, code)
    end
  end
end
