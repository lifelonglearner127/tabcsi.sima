# frozen_string_literal: true

module TabcSi
  module Helpers
    module General
      def logger
        TabcSi::Api.logger
      end

      def current_user
        @current_user ||= find_current_user
      end

      def current_application
        doorkeeper_token&.application
      end

      private

      def find_current_user
        user_id = doorkeeper_token&.resource_owner_id || params[:user_id]

        return nil unless user_id.present?

        User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
  end
end
