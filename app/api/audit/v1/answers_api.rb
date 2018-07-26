# frozen_string_literal: true

module Audit
  module V1
    class AnswersApi < Grape::API
      resources :answers do
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
