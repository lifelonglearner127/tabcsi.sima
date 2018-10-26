# frozen_string_literal: true

module TabcSi
  module Entities
    class InspectionEntity < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :user, using: UserEntity
      expose :location, using: LocationEntity
      expose :license, using: LicenseEntity

      expose :permit_name do |object|
        object.audit_form.permit_name
      end

      expose :report_number

      expose(
        :started_at,
        documentation: {
          desc: <<~DESC,
            The date-time when the inspection was started on the device. This is
            the client-side equivalent of `created_at`.
          DESC
          format: 'date-time'
        }
      )

      expose(
        :created_at,
        documentation: {
          desc: <<~DESC,
            The date-time when the inspection was created on the server. This is
            the server-side equivalent of `started_at`.
          DESC
          format: 'date-time'
        }
      )

      expose(
        :finished_at,
        documentation: {
          desc: <<~DESC,
            The date-time when the inspection was finished on the device. This
            is the client-side equivalent of `completed_at`.
          DESC
          format: 'date-time'
        }
      )

      expose(
        :completed_at,
        documentation: {
          desc: <<~DESC,
            The date-time when the inspection was completed on the server. This
            is the server-side equivalent of `finished_at`.
          DESC
          format: 'date-time'
        }
      )

      expose(
        :submitted_at,
        documentation: {
          desc: 'The date-time when the inspection was submitted to TABC.',
          format: 'date-time'
        }
      )

      expose :cancellation_reason

      expose(
        :cancelled_at,
        documentation: {
          desc: 'The date-time when the inspection was cancelled.',
          format: 'date-time'
        }
      )

      expose(
        :updated_at,
        documentation: {
          desc: 'The date-time when the inspection was last updated.',
          format: 'date-time'
        }
      )

      expose(
        :flagged,
        documentation: {
          desc: <<~DESC,
            Whether or not the inspection was flagged based on answers given.
          DESC
          type: 'boolean'
        }
      )

      expose(
        :flag_reason,
        documentation: {
          desc: <<~DESC
            The set of question numbers that caused the inspection to be
            flagged.
          DESC
        }
      )

      expose(
        :flagged_at,
        documentation: {
          desc: <<~DESC,
            When the inspection was flagged. This is set whether `flagged` is
            `true` or `false`.
          DESC
          format: 'date-time'
        }
      )

      expose(
        :answers,
        using: AnswerEntity,
        documentation: { is_array: true },
        if: { include_answers: true }
      )
    end
  end
end
