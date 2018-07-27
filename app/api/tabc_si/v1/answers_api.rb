# frozen_string_literal: true

module TabcSi
  module V1
    class AnswersApi < Grape::API
      resources :answers do
        desc 'Add Answers' do
          detail "Stores the user's answers for later processing."
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
