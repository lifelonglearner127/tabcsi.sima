# frozen_string_literal: true

module TabcSi
  module V1
    class LicensesApi < Grape::API
      resources :licenses do
        get do
          # licenses = License.all
          #
          # user =
          #   if email_filter.present?
          #     User.find_by(email: email_filter)
          #   else
          #     current_resource_owner
          #   end
          #
          # licenses = licenses.where(user: user) if user.present?
          #
          # success! licenses

          'GET licenses'
        end

        get :find do
          # license = License.find_by(license_number: license_number)
          #
          # if license.blank?
          #   fail!(
          #     'A License with the specified license number could not be found.'
          #   )
          # end
          #
          # success! license

          'GET licenses/find'
        end
      end
    end
  end
end
