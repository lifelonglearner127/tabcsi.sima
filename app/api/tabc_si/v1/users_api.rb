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
          requires :email, type: String, email: true
        end
        post :request_pin do
          email = params[:email]
          user = User.find_for_database_authentication(email: email)

          error_bad_request! "user doesn't exist" if user.blank?

          unless user.request_pin(web: false)
            error! 'could not generate a new pin'
          end

          no_content
        end

        desc(
          'Validate User',
          detail: <<~DESC,
            Checks if a specified email address is valid/exists. Can also check
            if a specified location is valid for the specified email address.
          DESC
          success: {
            code: 200,
            model: Entities::ValidateEntity,
            message: 'A validation object.'
          }
        )
        params do
          requires :email, type: String, email: true
          optional :location_id, type: Integer, id: true
        end
        post :validate do
          email = params[:email]
          user = User.find_for_database_authentication(email: email)
          valid_email = user.present?
          response = { valid_email: valid_email }

          location_id = params[:location_id]
          if location_id.present?
            valid_location = valid_email && user.locations.exists?(location_id)
            response[:valid_location] = valid_location
          end

          respond response
        end

        segment ':user_id' do
          desc(
            'Update User',
            detail: <<~DESC,
              Allows updating a user's profile. All params are optional,
              but at least one is required
            DESC
            success: {
              model: Entities::UserEntity,
              message: 'A user object.'
            }
          )
          params do
            optional(
              :full_name, type: String
            )

            optional(
              :email, type: String, email: true
            )
            optional(
              :phone, type: String
            )

            optional(
              :job_title, type: String
            )

            at_least_one_of :full_name, :email, :phone, :job_title
          end

          patch do
            user = params[:user]

            user.update!(
              full_name: params[:full_name],
              email: params[:email],
              phone: params[:phone],
              job_title: params[:job_title]
            )

            respond user
          end
        end
      end
    end
  end
end
