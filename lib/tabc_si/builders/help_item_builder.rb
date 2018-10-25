# frozen_string_literal: true

module TabcSi
  module Builders
    class HelpItemBuilder < Builder
      attr_reader :help_builder
      attr_reader :item

      def initialize(help_builder, config)
        super(config)

        @help_builder = help_builder
        @item = nil
      end

      def build
        @item = QuestionHelpItem.create!(
          parent: help_builder.question_builder.question,
          **attributes
        )
      end

      protected

      def parse_config
        super(%i[sort_order value])

        return unless attributes[:value].is_a?(Array)

        attributes[:value] = attributes[:value].join("\n")
      end
    end
  end
end
