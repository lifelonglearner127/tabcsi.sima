# frozen_string_literal: true

module TabcSi
  module Formatters
    module Success
      def self.call(object, _env)
        object.to_json
      end
    end
  end
end
