# frozen_string_literal: true

module TabcSi
  module Entities
    class AuditForm < Grape::Entity
      expose(
        :permit_name,
        documentation: {
          desc: 'The name of the permit that the questions apply to.'
        }
      )

      expose(
        :last_updated_at,
        documentation: {
          desc: 'The date and time of when any part of the audit form was' \
            ' last updated.',
          format: 'date-time'
        }
      )

      expose(
        :total_questions,
        documentation: {
          desc: 'The total number of questions.',
          type: 'integer'
        }
      ) do |object|
        object.audit_form_questions.count
      end

      expose(
        :audit_form_questions,
        using: Entities::AuditFormQuestion,
        as: :questions,
        documentation: { is_array: true }
      )
    end
  end
end
