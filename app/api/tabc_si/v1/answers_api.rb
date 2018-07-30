# frozen_string_literal: true

module TabcSi
  module V1
    class AnswersApi < Grape::API
      resources :answers do
        desc 'Add Answers' do
          detail "Stores the user's answers for later processing."
        end
        params do
          requires :license_number, type: String
          # requires :values, type: Array[Hash] do
          #   requires(
          #     :question_number,
          #     type: String,
          #     values: Question.pluck(:question_number)
          #   )
          #
          #   requires :value, type: String
          # end
        end
        post do
          # answers = map_values(license_number, values)
          #
          # success! answers

          'POST answers'
        end
      end
    end
  end
end
