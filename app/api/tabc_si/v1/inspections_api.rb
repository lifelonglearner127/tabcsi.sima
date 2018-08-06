# frozen_string_literal: true

module TabcSi
  module V1
    class InspectionsApi < Grape::API
      resources :inspections do
        desc(
          'Start Inspection',
          detail: 'Start an inspection for a specified location.',
          success: {
            model: Entities::InspectionEntity,
            message: 'An inspection object.'
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

        params do
          requires :inspection_id, type: Integer, desc: 'Inspection id.'
        end
        route_param :inspection_id do
          desc(
            'Finish Inspection',
            detail: 'Finish the specified inspection.',
            success: {
              model: Entities::InspectionEntity,
              message: 'An inspection object.'
            }
          )
          params do
            requires(
              :finished_at,
              type: String,
              desc: 'Date and time, in UTC, when the inspection was finished.',
              documentation: { format: 'date-time' }
            )
          end
          post :finish do
            inspection = Inspection.find(params[:inspection_id])

            if inspection.finished_at.present?
              error_bad_request! 'inspection has already been finished'
            end

            inspection.finish(params[:finished_at])

            respond inspection
          end
        end
      end
    end
  end
end
