# frozen_string_literal: true

module Audit
  class Error < RuntimeError
    attr_reader :code

    def initialize(message, code)
      if message.is_a?(Array)
        @errors = message
        message = nil
      end

      super(message)

      @code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code]
    end
  end
end
