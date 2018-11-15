# frozen_string_literal: true

module Doorkeeper
  module Validations
    module ClassMethods
      def validate(attribute, before: nil, after: nil, **options)
        validation = { attribute: attribute, options: options }

        if before || after
          index = validations.index { |v| v[:attribute] == (before || after) }

          validations.insert(index + (before ? 0 : 1), validation)
        else
          validations << validation
        end
      end
    end
  end
end
