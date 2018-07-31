# frozen_string_literal: true

module TabcSi
  module V1
    class UsersApi < Grape::API
      resources :users do
        desc(
          'Request User PIN',
          detail: 'Requests a new user PIN for signing in.',
          success: { code: 204, message: 'No Content' },
          failure: [
            { code: 400, message: "user doesn't exist" },
            { code: 500, message: 'could not generate a new pin' }
          ]
        )
        params do
          requires :email, type: String, allow_blank: false
        end
        post :request_pin do
          email = params[:email]
          user = User.find_by(email: email)

          error_bad_request! "user doesn't exist" if user.blank?

          pin = user.generate_pin

          error! 'could not generate a new pin' if pin.blank?

          UsersMailer.with(
            recipient: email,
            pin: pin
          ).request_pin.deliver_now

          no_content
        end

        desc(
          'Validate User Email',
          detail: 'Checks if a specified email address is valid/exists.',
          success: {
            code: 200,
            model: Entities::ValidateEmail,
            message: 'A validation object.'
          }
        )
        params do
          requires :email, type: String, allow_blank: false
        end
        post :validate_email do
          respond { valid_email: User.find_by(email: params[:email]).present? }
        end
      end
    end
  end
end
