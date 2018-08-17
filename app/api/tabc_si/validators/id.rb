# frozen_string_literal: true

module TabcSi
  module Validators
    class Id < Base
      def validate_param!(attr_name, params)
        value = params[attr_name]

        validation_failed!(attr_name, :id) if value.nil? || !value.positive?
      end
    end
  end
end
