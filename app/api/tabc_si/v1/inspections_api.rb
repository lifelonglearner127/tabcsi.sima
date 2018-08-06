# frozen_string_literal: true

module TabcSi
  module V1
    class InspectionsApi < Grape::API
      resources :inspections do
        desc(
          'Start Inspection',
          detail: '',
          success: {
            model: Entities::InspectionEntity,
            message: ''
          }
        )
        params do
          requires :location_id, type: Integer
          requires :audit_form_id, type: Integer

          requires(
            :started_at,
            type: String,
            desc: 'Date and time, in UTC, when the inspection was started.',
            documentation: { format: 'date-time' }
          )
        end
        post do
          location = Location.find(params[:location_id])
          audit_form = AuditForm.find(params[:audit_form_id])

          if location.locked?
            error_bad_request! 'inspection already started for location'
          end

          inspection = Inspection.create!(
            location: location,
            audit_form: audit_form,
            user: current_user,
            started_at: params[:started_at]
          )

          respond inspection
        end
      end
    end
  end
end
