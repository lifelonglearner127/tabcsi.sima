# frozen_string_literal: true

Rails.application.routes.draw do
  root 'doorkeeper/applications#index'

  use_doorkeeper do
    skip_controllers :authorized_applications
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

      namespace :users do
        post :validate_email, to: 'sessions#validate_email'
        post :request_pin, to: 'sessions#request_pin'
      end
    end
  end
end
