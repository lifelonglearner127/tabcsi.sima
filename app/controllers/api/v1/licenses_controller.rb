# frozen_string_literal: true

module Api
  module V1
    class LicensesController < BaseV1Controller
      def index
        licenses = License.all

        if filter.present?
          user =
            if email_filter.present?
              User.find_by(email: email_filter)
            else
              current_resource_owner
            end

          licenses = licenses.where(user: user) if user.present?
        end

        success! licenses: licenses
      end

      private

      def filter
        @filter ||= params[:filter] || {}
      end

      def email_filter
        @email_filter ||= filter.delete(:email)
      end

      def licenses_as_json(licenses)
        ActiveModelSerializers::SerializableResource
          .new(licenses, include: '')
          .as_json
      end
    end
  end
end
