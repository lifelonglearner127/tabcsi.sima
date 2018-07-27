# frozen_string_literal: true

module TabcSi
  module Helpers
    module Errors
      {
        not_found: 'Resource not found.'
      }.each do |code, message|
        define_method "error_#{code}!" do
          raise Error.new(message, code)
        end
      end

      def error_bad_request!(*errors)
        raise Error.new(errors, :bad_request)
      end
    end
  end
end
