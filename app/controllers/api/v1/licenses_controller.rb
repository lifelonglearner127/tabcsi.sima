# frozen_string_literal: true

module Api
  module V1
    class LicensesController < BaseV1Controller
      def index
        licenses = License.all

        user =
          if email_filter.present?
            User.find_by(email: email_filter)
          else
            current_resource_owner
          end

        licenses = licenses.where(user: user) if user.present?

        success! licenses
      end

      def find
        license = License.find_by(license_number: license_number)

        if license.blank?
          fail!(
            'A License with the specified license number could not be found.'
          )
        end

        success! license
      end

      private

      def filter
        @filter ||= params[:filter] || {}
      end

      def email_filter
        @email_filter ||= filter.delete(:email)
      end

      def license_number
        @license_number ||= params.require(:license_number)
      end
    end
  end
end
