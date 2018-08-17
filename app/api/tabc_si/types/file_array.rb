# frozen_string_literal: true

module TabcSi
  module Types
    class FileArray < Array
      def self.parse(value)
        raise 'not an array' unless value.is_a?(Array)

        value.each do |file|
          unless file.is_a?(Hash) && file.key?(:tempfile)
            raise 'array contains invalid file(s)'
          end
        end

        value
      end
    end
  end
end
