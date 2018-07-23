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

      def create
        fail! 'No user present.' if current_resource_owner.blank?

        license = License.create!(
          user: current_resource_owner,
          license_number: license_number,
          front_lat: front_lat,
          front_long: front_long,
          back_lat: back_lat,
          back_long: back_long,
          photos: photos
        )

        success! license: as_json(license)
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

      def front
        @front ||= params.require(:front)
      end

      def front_lat
        @front_lat ||= front.require(:lat)
      end

      def front_long
        @front_long ||= front.require(:long)
      end

      def back
        @back ||= params.require(:back)
      end

      def back_lat
        @back_lat ||= back.require(:lat)
      end

      def back_long
        @back_long ||= back.require(:long)
      end

      def photos
        @photos ||= params.require(:photos)
      end
    end
  end
end
