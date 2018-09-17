# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboards#show'

  use_doorkeeper do
    if Rails.env.production?
      skip_controllers(
        :applications, :authorizations, :authorized_applications, :token_info
      )
    end
  end

  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'

  get :log_in, to: 'sessions#new'
  post :log_in, to: 'sessions#create'
  post :resend_pin, to: 'sessions#resend_pin'
  delete :log_out, to: 'sessions#destroy'

  get :dashboard, to: 'dashboards#show'

  resources :faqs, only: %i[index]

  resources :questions, only: %i[] do
    collection do
      get :help
    end
  end

  namespace :api do
    get(
      ':version/docs',
      action: :docs,
      format: false,
      constraints: AllowedIpConstraint
    )
  end

  mount TabcSi::Api => '/'
end
