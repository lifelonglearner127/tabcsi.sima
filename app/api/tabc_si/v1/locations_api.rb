# frozen_string_literal: true

module TabcSi
  module V1
    class LocationsApi < Grape::API
      resources :locations do
        desc(
          'Get Locations',
          detail: 'Returns all locations. If a password authorization token' \
            ' is used, then returns only locations associated with the' \
            ' attached user.',
          is_array: true,
          success: {
            model: Entities::Location,
            message: 'A location object.'
          }
        )
        get do
          locations = current_user&.locations || Location.all

          respond locations
        end

        # params do
        #   requires :id, type: Integer, desc: 'Location id.'
        # end
        # route_param :id do
        #   get :history do
        #   end
        # end
      end
    end
  end
end
