# frozen_string_literal: true

module TabcSi
  module Builders
    class FormBuilder < Builder
      attr_reader :form
      attr_reader :form_questions
      attr_reader :permit_name
      attr_reader :questions

      def initialize(permit_name, config)
        super(config)

        @permit_name = permit_name
      end

      def build(questions)
        @questions = questions
        @form = AuditForm.create!(permit_name: permit_name)

        form_questions.each do |form_question_builder|
          question_number = form_question_builder.question_number.to_sym
          question_builder = questions[question_number]

          form_question_builder.build(question_builder)
        end
      end

      def next_question_group_number(current_question_number)
        form_question_builder =
          form_questions.find do |fqb|
            fqb.question_number.to_i > current_question_number
          end

        form_question_builder&.question_number
      end

      protected

      def parse_config
        @form_questions =
          config.map do |question_number|
            FormQuestionBuilder.new(self, question_number)
          end
      end
    end
  end
end
