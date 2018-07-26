# frozen_string_literal: true

module Audit
  module V1
    class SettingsApi < Grape::API
      resources :settings do
        get do
          Setting.all
        end
      end
    end
  end
end
