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

  resource(:import, only: %i[]) do
    get :upload_csv
    post :users
  end

  resources(:locations, only: %i[]) do
    member do
      post :reset
    end
  end

  resources :news, only: %i[create destroy edit new show update]

  # HighVoltage
  get '/pages/*id', to: 'pages#show', as: :page, format: false

  resources(:questions, only: %i[]) do
    collection do
      get :help
    end
  end

  resource(:session, only: %i[], path: '', as: '') do
    get :log_in, action: :new
    post :log_in, action: :create
    delete :log_out, action: :destroy

    post :resend_pin
  end

  resources(:users, only: %i[destroy edit]) do
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

  resource :verification, only: %i[show]

  mount ActionCable.server => '/cable'

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
