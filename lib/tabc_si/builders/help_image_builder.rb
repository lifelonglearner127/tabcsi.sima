# frozen_string_literal: true

module TabcSi
  module Builders
    class HelpImageBuilder < Builder
      attr_reader :help_builder
      attr_reader :image

      def initialize(help_builder, config)
        super(config)

        @help_builder = help_builder
        @image = nil
      end

      def build
        @image = QuestionHelpImage.create!(
          parent: help_builder.question_builder.question,
          **attributes
        )
      end

      protected

      def parse_config
        super(%i[path sort_order])
      end
    end
  end
end
