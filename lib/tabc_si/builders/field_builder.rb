# frozen_string_literal: true

module TabcSi
  module Builders
    class FieldBuilder < Builder
      attr_reader :choice_builder
      attr_reader :field

      def initialize(choice_builder, config)
        super(config)

        @choice_builder = choice_builder
        @field = nil
      end

      def build
        @field = Field.create!(
          choice: choice_builder.choice,
          **attributes
        )
      end

      protected

      def parse_config
        super(%i[label field_type])
      end
    end
  end
end
