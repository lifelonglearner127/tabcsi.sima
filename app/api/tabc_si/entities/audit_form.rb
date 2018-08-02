# frozen_string_literal: true

module TabcSi
  module Entities
    class AuditForm < Grape::Entity
      expose :permit_name
      expose :last_updated_at, documentation: { format: 'date-time' }

      expose(:total_questions, documentation: { type: 'integer' }) do |object|
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
