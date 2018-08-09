# frozen_string_literal: true

module TabcSi
  module Builders
    class ChoiceBuilder < Builder
      attr_reader :choice
      attr_reader :fields
      attr_reader :question_builder

      def initialize(question_builder, config)
        super(config)

        @choice = nil
        @question_builder = question_builder
      end

      def build
        @choice = Choice.create!(
          question: question_builder.question,
          **attributes
        )

        fields.each(&:build)
      end

      protected

      def parse_config
        super(%i[choice_text picture_attachment])

        @fields = wrap_fields(config[:fields] || [])
      end

      private

      def wrap_fields(field_configs)
        field_configs.map do |field_config|
          FieldBuilder.new(self, field_config)
        end
      end
    end
  end
end
