# frozen_string_literal: true

module Api
  module V1
    class AnswersController < BaseV1Controller
      def create
        answers = map_values(license_number, values)

        success! answers: as_json(answers)
      end

      private

      def license_number
        @license_number ||= params.require(:license_number)
      end

      def values
        @values ||= validate_values_param(params.require(:values))
      end

      def validate_values_param(values_param)
        unless values_param.is_a?(ActionController::Parameters)
          fail!(
            'The `values` parameter must be a hash, a collection of' \
            ' question-id:value pairs.'
          )
        end

        values = {}

        values_param.permit!.each do |question_number, value|
          question = Question.find_by(question_number: question_number)

          fail! "Invalid question-id: #{question_number}" if question.blank?

          values[question.id] = value
        end

        values
      end

      def map_values(license_number, values)
        answers = []

        values.each do |question_id, value|
          answers << Answer.create!(
            question_id: question_id,
            license_number: license_number,
            answer_value: value
          )
        end

        answers
      end
    end
  end
end
