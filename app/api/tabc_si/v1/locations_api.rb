# frozen_string_literal: true

module TabcSi
  module V1
    class LocationsApi < Grape::API
      resources :locations do
        desc(
          'Get Locations',
          detail: <<~DESC,
            Returns all locations. If a password authorization token is used,
            then returns only locations associated with the attached user.
          DESC
          is_array: true,
          success: {
            model: Entities::LocationEntity,
            message: 'A location object.'
          }
        )
        get do
          locations = current_user&.locations || Location.all

          respond locations
        end

        params do
          requires :location_id, type: Integer, desc: 'Location id.'
        end
        route_param :location_id do
          desc(
            'Get Location History',
            detail: 'Returns the locations inspection history.',
            is_array: true,
            success: {
              model: Entities::InspectionEntity,
              message: 'An inspection object.'
            }
          )
          get :history do
            location = Location.find(params[:location_id])

            respond location.inspections
          end
        end
      end
    end
  end
end
