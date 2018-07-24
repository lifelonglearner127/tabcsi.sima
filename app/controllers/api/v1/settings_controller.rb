# frozen_string_literal: true

module Api
  module V1
    class SettingsController < BaseV1Controller
      def index
        success! Setting.all
      end
    end
  end
end
