# frozen_string_literal: true

module TabcSi
  class Error < StandardError
    attr_reader :status
    attr_reader :code
    attr_reader :title
    attr_reader :detail

    def initialize(title, detail: nil, status: :bad_request, code: nil)
      super(title)

      @title = title
      @detail = detail || title
      self.status = status
      @code = code || self.status
    end

    def status=(value)
      @status =
        (value.is_a?(Symbol) && Rack::Utils::SYMBOL_TO_STATUS_CODE[value]) ||
        value
    end
  end
end
