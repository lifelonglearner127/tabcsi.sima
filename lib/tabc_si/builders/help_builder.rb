# frozen_string_literal: true

module TabcSi
  module Builders
    class HelpBuilder < Builder
      attr_reader :question_builder
      attr_reader :help

      def initialize(question_builder, config)
        super(config)

        @question_builder = question_builder
        @help = nil
      end

      def build
        @help = QuestionHelpItem.create!(
          parent: question_builder.question,
          **attributes
        )
      end

      protected

      def parse_config
        super(%i[value sort_order])

        if attributes[:value].is_a?(Array)
          attributes[:value] = attributes[:value].join("\n")
        end
      end
    end
  end
end
