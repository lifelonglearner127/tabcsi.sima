# frozen_string_literal: true

# Hack to allow client tokens.

module Devise
  module Strategies
    class Doorkeeper < ::Devise::Strategies::Authenticatable
      def authenticate!
        token = ::Doorkeeper.authenticate(request)
        if token.present?
          if token.resource_owner_id.present?
            resource = resource_from_token(token)

            if validate(resource)
              request.env['devise.skip_trackable'] = true
              success!(resource)
            end
          else
            success!(true)
          end
        else
          invalid_token
        end
      end

      private

      def resource_from_token(token)
        scopes = ::Doorkeeper.configuration.default_scopes

        invalid_token unless token.acceptable?(scopes)

        mapping.to.find(token.resource_owner_id)
      end
    end
  end
end
