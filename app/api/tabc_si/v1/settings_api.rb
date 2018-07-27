# frozen_string_literal: true

module TabcSi
  module V1
    class SettingsApi < Grape::API
      resources :settings do
        desc 'Get Settings' do
          detail 'Retrieves all global settings.'
        end
        get do
          Setting.all
        end
      end
    end
  end
end
