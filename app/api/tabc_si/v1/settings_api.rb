# frozen_string_literal: true

module TabcSi
  module V1
    class SettingsApi < Grape::API
      resources :settings do
        desc(
          'Get Settings',
          detail: 'Retrieves all global settings.',
          is_array: true,
          success: {
            model: Entities::Setting,
            message: 'A collection of system-level settings.'
          }
        )
        get do
          respond Setting.all
        end
      end
    end
  end
end
