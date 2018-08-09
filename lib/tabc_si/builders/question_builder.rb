# frozen_string_literal: true

module TabcSi
  module Builders
    class QuestionBuilder < Builder
      attr_reader :choices
      attr_reader :conditions
      attr_reader :question
      attr_reader :question_number

      def initialize(question_number, config)
        super(config)

        @question = nil
        @question_number = question_number
      end

      def build
        @question = Question.create!(
          question_number: question_number,
          **attributes
        )

        choices.each(&:build)
      end

      protected

      def parse_config
        super(%i[
          question_text question_type max_characters multiline source other
          multiple
        ])

        @choices = wrap_choices(config[:choices] || [])
        @conditions = wrap_conditions(config[:conditions] || [])
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
    end
  end
end
