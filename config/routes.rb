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

  get :dashboard, to: 'dashboards#show'

  resources :faqs, only: %i[index]

  resources :news, only: %i[create edit new show update destroy]

  resources :questions, only: %i[] do
    collection do
      get :help
    end
  end

  get :log_in, to: 'sessions#new'
  post :log_in, to: 'sessions#create'
  post :resend_pin, to: 'sessions#resend_pin'
  delete :log_out, to: 'sessions#destroy'

  resources :users, only: %i[destroy edit] do
    collection do
      get :invite
      post :invite, action: :create
    end

    member do
      patch :edit, action: :update
      post :undiscard
    end
  end
  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'

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
