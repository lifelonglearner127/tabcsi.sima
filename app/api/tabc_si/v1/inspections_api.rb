# frozen_string_literal: true

module TabcSi
  module V1
    class InspectionsApi < Grape::API
      DROP_DOWN_FORMAT ||= <<~DESC
        Value format (braced text should be replaced with actual values):

            {vendor name};{vendor name};...

        Example:

            ATX WHOLESALE LIQUORS LLC;BEN E. KEITH BEVERAGES;CRAFT DISTRIBUTORS TEXAS LLC
      DESC

      QUESTION_DESCRIPTIONS ||= {
        '12': DROP_DOWN_FORMAT,
        '13': DROP_DOWN_FORMAT,
        '26B': <<~DESC,
          Value format (braced text should be replaced with actual values):

              {radio text}: [{field label}: {start value}-{end value}, ...]

          Example:
              Monday - Friday: [Food: 7:00AM-11:00PM, Alcohol: 10:00AM-10:00PM]
        DESC
        '27': <<~DESC
          Value format (braced text should be replaced with actual values):

              {radio text}: [{field label}: {start value}-{end value}, ...]

          Example:
              Friday: [Alcohol: 10:00AM-10:00PM]
        DESC
      }.freeze

      # def self.collect_questions
      #   questions = Question.order(id: :asc)
      #   picture_questions =
      #     questions
      #     .includes(:choices)
      #     .where(choices: { picture_attachment: true })
      #
      #   questions.map do |q|
      #     [q.question_number, picture_questions.include?(q)]
      #   end
      # end

      def self.questions
        # guard for test environment
        if ActiveRecord::Base.connection.migration_context.needs_migration?
          return []
          # return {}
        end

        @questions ||= Question.order(id: :asc)
        # @questions ||= Hash[collect_questions]
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

        def verify_user!(inspection)
          if inspection.user_id != current_user&.id
            error_bad_request! 'user did not start the inspection'
          end

          unless inspection.location.users.include?(current_user)
            error_bad_request! 'user is no longer assigned to location'
          end

          return if inspection.license.users.include?(current_user)

          error_bad_request! 'user is no longer assigned to license'
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
          requires :audit_form_id, type: Integer, entity: AuditForm
          requires :location_id, type: Integer, entity: Location
          requires :license_id, type: Integer, entity: License

          requires(
            :started_at,
            type: DateTime,
            desc: 'Date and time, in UTC, when the inspection was started.',
            documentation: { type: 'string', format: 'date-time' }
          )
        end
        post do
          location = params[:location]
          license = params[:license]

          if location.locked?
            error_bad_request! 'inspection already started for location'
          end

          error_bad_request! 'location already inspected' if location.inspected?

          unless location.users.include?(current_user)
            error_bad_request! 'user is not assigned to location'
          end

          unless license.users.include?(current_user)
            error_bad_request! 'user is not assigned to license'
          end

          inspection = Inspection.create!(
            audit_form: params[:audit_form],
            user: current_user,
            location: location,
            license: license,
            started_at: params[:started_at]
          )

          respond inspection
        end

        params do
          requires(
            :inspection_id,
            type: Integer,
            entity: Inspection,
            desc: 'Inspection id.'
          )
        end
        segment ':inspection_id' do
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
                optional(
                  q.question_number,
                  type: String,
                  desc: QUESTION_DESCRIPTIONS[q.question_number.to_sym]
                )
              end
            end

            optional(:pictures, type: Hash, default: {}) do
              InspectionsApi.picture_questions.each do |q|
                optional q.question_number, type: Array[File]
                # optional q.question_number, type: Types::FileArray
                # optional q.question_number, type: Array do
                #   requires :filename
                #   requires :type
                #   requires :name
                #   requires :tempfile
                #   requires :head
                # end
              end
            end
          end
          post :finish do
            inspection = params[:inspection]

            if inspection.finished_at.present?
              error_bad_request! 'inspection has already been finished'
            end

            verify_user!(inspection)

            answers = process_answers(params[:answers], params[:pictures])
            inspection.finish(params[:finished_at], answers)

            respond inspection
          end

          desc(
            'Cancel Inspection',
            detail: 'Cancels the started inspection.',
            success: {
              model: Entities::InspectionEntity,
              message: 'An inspection object.'
            }
          )
          params do
            optional :reason, type: String
          end
          post :cancel do
            inspection = params[:inspection]

            if inspection.finished_at.present?
              error_bad_request! 'cannot cancel a finished inspection'
            end

            verify_user!(inspection)

            inspection.cancel(params[:reason])

            respond inspection
          end
        end
      end
    end
  end
end
