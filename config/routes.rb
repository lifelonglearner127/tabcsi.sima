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
