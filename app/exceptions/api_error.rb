# frozen_string_literal: true

class ApiError < RuntimeError
  attr_reader :status, :data, :code, :status_code

  def initialize(status, data, message, code)
    super(message)

    @status = status
    @data = data
    @code = code
  end

  def to_json
    json = {
      status: status.to_s
    }

    case status
    when :success, :fail
      json[:data] = data
      @status_code = status == :success ? :ok : code
    else
      json[:message] = message
      json[:code] = code if code.present?
      json[:data] = data if data.present?
      @status_code = code || :internal_server_error
    end

    json.to_json
  end
end
