# frozen_string_literal: true

module TabcSi
  module V1
    class PushTokensApi < Grape::API
      helpers do
        def valid_device_type?(device_type)
          PushToken.device_types.key?(device_type)
        end
      end

      resources :push_tokens do
        desc(
          'Add Push Token',
          detail: <<~DESC,
            Add a push token for the user attached to the password authorization
            token used.
          DESC
          success: {
            code: 200,
            model: Entities::PushTokenEntity,
            message: 'The created push token object.'
          }
        )
        params do
          requires :token, type: String

          optional(
            :device_type, type: String, values: PushToken.device_types.keys
          )
        end
        post do
          if current_application.blank?
            bad_request_error! 'missing OAuth application'
          end

          if current_user.blank?
            bad_request_error! 'missing user; please use a password token'
          end

          device_type = params[:device_type] || current_application.name
          unless valid_device_type?(device_type)
            bad_request_error! <<~MSG
              invalid device type from authorization token; please specify `device_type` parameter
            MSG
          end

          push_token = PushToken.create!(
            user: current_user,
            device_type: device_type,
            token: params[:token]
          )

          respond push_token
        end
      end
    end
  end
end
