# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < BaseV1Controller
        def request_pin
          email = params[:email]
          fail! 'Missing required parameter: email' if email.blank?

          user = User.find_by(email: email)
          fail! 'Unknown user.' if user.blank?

          pin = user.generate_pin

          UsersMailer.with(
            recipient: email,
            pin: pin
          ).request_pin.deliver_now

          head :no_content
        end

        def validate_email
          success!(
            is_valid: User.find_by(email: params[:email]).present?
          )
        end
      end
    end
  end
end
