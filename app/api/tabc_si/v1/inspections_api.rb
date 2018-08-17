# frozen_string_literal: true

module TabcSi
  module V1
    class InspectionsApi < Grape::API
      def self.questions
        # guard for test environment
        if ActiveRecord::Base.connection.migration_context.needs_migration?
          return []
        end

        @questions ||= Question.order(id: :asc)
      end

      def self.picture_questions
        return [] if questions.blank?

        @picture_questions ||=
          questions
          .includes(:choices)
          .where(choices: { picture_attachment: true })
      end

      helpers do
        def process_answers(answers, pictures)
          answers.each_with_object({}) do |(question_number, value), obj|
            pics =
              pictures[question_number]&.map do |p|
                ActionDispatch::Http::UploadedFile.new(p)
              end

            obj[question_number] = {
              value: value,
              pictures: pics
            }
          end
        end
      end

      resources :inspections do
        desc(
          'Start Inspection',
          detail: <<~DESC,
            Start an inspection for a specified location. A password
            authorization token is required.
          DESC
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
            type: DateTime,
            desc: 'Date and time, in UTC, when the inspection was started.',
            documentation: { type: 'string', format: 'date-time' }
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
              type: DateTime,
              desc: 'Date and time, in UTC, when the inspection was finished.',
              documentation: { type: 'string', format: 'date-time' }
            )

            requires(:answers, type: Hash) do
              InspectionsApi.questions.each do |q|
                optional q.question_number, type: String
              end
            end

            optional(:pictures, type: Hash, default: {}) do
              InspectionsApi.picture_questions.each do |q|
                optional q.question_number, type: Array[File]
              end
            end
          end
          post :finish do
            inspection = Inspection.find(params[:inspection_id])

            if inspection.finished_at.present?
              error_bad_request! 'inspection has already been finished'
            end

            inspection.finish(
              params[:finished_at],
              process_answers(params[:answers], params[:pictures])
            )

            respond inspection
          end
        end
      end
    end
  end
end
