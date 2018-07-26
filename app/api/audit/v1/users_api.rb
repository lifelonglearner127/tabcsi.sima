# frozen_string_literal: true

module Audit
  module V1
    class UsersApi < Grape::API
      resources :users do
        post :request_pin do
          # email = params[:email]
          # fail! 'Missing required parameter: email' if email.blank?
          #
          # user = User.find_by(email: email)
          # fail! 'Unknown user.' if user.blank?
          #
          # pin = user.generate_pin
          #
          # error! 'There was a problem generating a new pin.' if pin.blank?
          #
          # UsersMailer.with(
          #   recipient: email,
          #   pin: pin
          # ).request_pin.deliver_now
          #
          # head :no_content

          'POST users/request_pin'
        end

        params do
          requires :email, type: String
        end
        post :validate_email do
          { is_valid: User.find_by(email: params[:email]).present? }
        end
      end
    end
  end
end
