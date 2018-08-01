# frozen_string_literal: true

module TabcSi
  module Entities
    class AuditForm < Grape::Entity
      expose :permit_name
      expose :last_updated_at

      expose :total_questions do |object|
        object.audit_form_questions.count
      end

      expose(
        :audit_form_questions,
        using: Entities::AuditFormQuestion,
        as: :questions
      )
    end
  end
end
