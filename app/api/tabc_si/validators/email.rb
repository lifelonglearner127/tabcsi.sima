# frozen_string_literal: true

module TabcSi
  module Validators
    class Email < Base
      def validate_param!(attr_name, params)
        value = params[attr_name]

        validation_failed!(attr_name, :email) unless TabcSi::Email.valid?(value)

        params[attr_name].downcase!
      end
    end
  end
end
