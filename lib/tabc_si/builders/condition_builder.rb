# frozen_string_literal: true

module TabcSi
  module Builders
    class ConditionBuilder < Builder
      attr_reader :condition

      def initialize(config)
        super(config)

        @condition = nil
      end

      def build(form_question_builder)
        if skip_question_group?
          attributes[:conditional_question_number] =
            form_question_builder.form_builder.next_question_group_number(
              form_question_builder.question_number.to_i
            )
        end

        @condition = Condition.create!(
          audit_form_question: form_question_builder.form_question,
          **attributes
        )
      end

      def skip_question_group?
        @skip_question_group
      end

      protected

      def parse_config
        super(%i[condition_value conditional_question_number])

        @skip_question_group = config[:skip_question_group]
      end
    end
  end
end
