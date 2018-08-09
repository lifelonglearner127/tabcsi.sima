# frozen_string_literal: true

module TabcSi
  module Builders
    class FormBuilderMap < Hash
      def initialize(json)
        json.map do |permit_name, config|
          store(
            permit_name.to_sym,
            Builders::FormBuilder.new(permit_name, config)
          )
        end
      end
    end
  end
end
