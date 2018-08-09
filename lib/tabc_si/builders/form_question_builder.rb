# frozen_string_literal: true

module TabcSi
  module Builders
    class FormQuestionBuilder < Builder
      attr_reader :form_builder
      attr_reader :form_question
      attr_reader :question_number

      def initialize(form_builder, question_number)
        super()

        @form_builder = form_builder
        @question_number = question_number
      end

      def build(question_builder)
        @form_question = AuditFormQuestion.create!(
          audit_form: form_builder.form,
          question: question_builder.question
        )

        question_builder.conditions.each do |condition_builder|
          condition_builder.build(self)
        end
      end
    end
  end
end
