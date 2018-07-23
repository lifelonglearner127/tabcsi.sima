# frozen_string_literal: true

module Api
  module V1
    class LicensesController < BaseV1Controller
      def index
        success! licenses: []
      end

      private

      def filter
        @filter ||= params[:filter] || {}
      end

      def email_filter
        @email_filter ||= filter[:email]
      end
    end
  end
end
