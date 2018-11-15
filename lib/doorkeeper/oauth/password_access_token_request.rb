# frozen_string_literal: true

module Doorkeeper
  module OAuth
    class PasswordAccessTokenRequest < BaseRequest
      validate(
        :account_unlocked,
        before: :resource_owner,
        error: :locked_account
      )

      private

      def validate_account_unlocked
        user = resource_owner

        if user.blank?
          user =
            User.find_for_database_authentication(email: parameters[:username])

          return true if user.blank?
        end

        !user.access_locked?
      end
    end
  end
end
