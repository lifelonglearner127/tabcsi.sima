# frozen_string_literal: true

module TabcSi
  module Builders
    class QuestionBuilder < Builder
      attr_reader :build_date
      attr_reader :choices
      attr_reader :conditions
      attr_reader :help
      attr_reader :question
      attr_reader :question_number

      def initialize(question_number, config, build_date)
        super(config)

        @question = nil
        @question_number = question_number
        @build_date = build_date
      end

      def build
        @question = Question.create!(
          question_number: question_number,
          built_on: build_date,
          **attributes
        )

        choices.each(&:build)
        help.each(&:build)
      end

      protected

      def parse_config
        super(%i[
          question_text question_type max_characters multiline source other
          multiple label additional_label additional_text additional_type
        ])

        @choices = wrap_choices(config[:choices] || [])
        @conditions = wrap_conditions(config[:conditions] || [])
        @help = wrap_help(config[:help] || [])
      end

      private

      def wrap_choices(choice_configs)
        choice_configs.map do |choice_config|
          ChoiceBuilder.new(self, choice_config)
        end
      end

      def wrap_conditions(condition_configs)
        condition_configs.map do |condition_config|
          ConditionBuilder.new(condition_config)
        end
      end

      def wrap_help(help)
        sort_order = 0
        help.map do |item|
          sort_order += 1

          HelpBuilder.new(
            self,
            value: item,
            sort_order: sort_order
          )
        end
      end
    end
  end
end
