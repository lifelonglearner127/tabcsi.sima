# frozen_string_literal: true

module Api
  class BaseApiController < ActionController::API
    respond_to :json

    rescue_from StandardError do |e|
      raise e unless %r{^/api}.match?(request.env['ORIGINAL_FULLPATH'])

      unless e.is_a?(ApiError)
        message = "#{e.class.name} : #{e.message}"
        error_data = nil
        error_data = { trace: e.backtrace } if Rails.env.development?

        e = ApiError.new(:error, error_data, message, :internal_server_error)
      end

      render json: e.to_json, status: e.status_code
    end

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def success!(data)
      jsend!(:success, data)
    end

    def fail!(data, code = :bad_request)
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
