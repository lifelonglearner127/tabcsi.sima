# frozen_string_literal: true

Rails.application.routes.draw do
  root 'doorkeeper/applications#index'

  use_doorkeeper do
    if Rails.env.production?
      skip_controllers(
        :applications, :authorizations, :authorized_applications, :token_info
      )
    end
  end

  namespace(:api, defaults: { format: :json }) do
    namespace(
      :v1 # , constraints: ApiConstraints.new(version: 1, default: true)
    ) do
      devise_for(
        :users,
        controllers: { registrations: 'api/v1/users/registrations' },
        skip: %i[password sessions]
      )

      resources :answers, only: %i[create]

      resources :audit_forms, only: %i[] do
        collection do
          get :find
        end
      end

      resources :distributors, only: %i[index]

      resources :licenses, only: %i[index] do
        collection do
          get :find
        end
      end

      resources :push_tokens, only: %i[create]
      resources :settings, only: %i[index]

      namespace :users do
        post :validate_email, to: 'sessions#validate_email'
        post :request_pin, to: 'sessions#request_pin'
      end

      resources :vendors, only: %i[] do
        collection do
          get :names
        end
      end
    end
  end

  # Temporary scope to maintain existing APIs.
  scope :grape do
    namespace :api do
      get(
        ':version/docs',
        action: :docs,
        format: false,
        constraints: AllowedIpConstraint.new
      )
    end

    mount TabcSi::Api => '/'
  end
end
