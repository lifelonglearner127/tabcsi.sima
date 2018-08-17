# frozen_string_literal: true

module TabcSi
  module Validators
    class Base < Grape::Validations::Base
      protected

      def validation_failed!(attr_name, key)
        raise(
          Grape::Exceptions::Validation,
          params: [@scope.full_name(attr_name)],
          message: message(key)
        )
      end

      def option_value
        options_key?(:value) ? @option[:value] : @option
      end
    end
  end
end
