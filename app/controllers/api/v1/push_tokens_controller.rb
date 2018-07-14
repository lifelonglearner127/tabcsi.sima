# frozen_string_literal: true

module Api
  module V1
    class PushTokensController < BaseV1Controller
      def create
        token = push_token_params[:token]

        fail! 'No OAuth application present.' if current_application.blank?
        fail! 'No user present.' if current_resource_owner.blank?

        device_type = current_application.name.to_sym
        unless valid_device_type?(device_type)
          device_type = push_token_params[:device_type]
          fail! 'Invalid device type.' unless valid_device_type?(device_type)
        end

        push_token = PushToken.create!(
          user: current_resource_owner,
          device_type: device_type,
          token: token
        )

        success!(
          user_id: push_token.user.id,
          device_type: push_token.device_type,
          token: push_token.token
        )
      end

      private

      def push_token_params
        {
          token: params.require(:token),
          device_type: params[:device_type]&.to_s&.downcase
        }
      end

      def valid_device_type?(device_type)
        PushToken.device_types.key?(device_type)
      end
    end
  end
end
