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

        success! licenses: as_json(licenses)
      end

      private

      def filter
        @filter ||= params[:filter] || {}
      end

      def email_filter
        @email_filter ||= filter.delete(:email)
      end
    end
  end
end
