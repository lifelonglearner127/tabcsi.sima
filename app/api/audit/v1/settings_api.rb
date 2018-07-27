# frozen_string_literal: true

module Audit
  module V1
    class SettingsApi < Grape::API
      resources :settings do
        desc 'Get Settings' do
          detail 'Retrieve all global settings.'
        end
        get do
          Setting.all
        end
      end
    end
  end
end
