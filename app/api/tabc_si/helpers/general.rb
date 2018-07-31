# frozen_string_literal: true

module TabcSi
  module Helpers
    module General
      def logger
        TabcSi::Api.logger
      end

      def current_user
        return nil unless doorkeeper_token&.resource_owner_id

        User.find(doorkeeper_token.resource_owner_id)
      end

      def current_application
        doorkeeper_token&.application
      end
    end
  end
end
