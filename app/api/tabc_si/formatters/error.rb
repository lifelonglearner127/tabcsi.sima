# frozen_string_literal: true

module TabcSi
  module Formatters
    module Error
      extend Grape::ErrorFormatter::Base

      def self.call(
        message, _backtrace, _options = {}, _env = nil,
        _original_exception = nil
      )
        message = [message] unless message.is_a?(Array)

        { errors: message }.to_json
      end
    end
  end
end
