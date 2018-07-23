# frozen_string_literal: true

module Api
  module V1
    class PushTokensController < BaseV1Controller
      def create
        fail! 'No OAuth application present.' if current_application.blank?
        fail! 'No user present.' if current_resource_owner.blank?

        device_type = self.device_type
        unless valid_device_type?(device_type)
          device_type = current_application.name.to_sym
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

      def token
        @token ||= params.require(:token)
      end

      def device_type
        @device_type ||= params[:device_type]&.to_s&.downcase
      end

      def valid_device_type?(device_type)
        PushToken.device_types.key?(device_type)
      end
    end
  end
end
