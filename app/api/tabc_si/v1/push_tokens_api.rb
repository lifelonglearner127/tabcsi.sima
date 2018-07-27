# frozen_string_literal: true

module TabcSi
  module V1
    class PushTokensApi < Grape::API
      resources :push_tokens do
        post do
          # fail! 'No OAuth application present.' if current_application.blank?
          # fail! 'No user present.' if current_resource_owner.blank?
          #
          # device_type = __send__(:device_type)
          # unless valid_device_type?(device_type)
          #   device_type = current_application.name.to_sym
          #   fail! 'Invalid device type.' unless valid_device_type?(device_type)
          # end
          #
          # push_token = PushToken.create!(
          #   user: current_resource_owner,
          #   device_type: device_type,
          #   token: token
          # )
          #
          # success! push_token

          'POST push_tokens'
        end
      end
    end
  end
end
