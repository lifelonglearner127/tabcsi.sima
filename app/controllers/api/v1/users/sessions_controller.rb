# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < BaseApiController
        before_action :authenticate_api_v1_user!

        def validate_email
          @is_valid = User.find_by(email: params[:email]).present?
        end
      end
    end
  end
end
