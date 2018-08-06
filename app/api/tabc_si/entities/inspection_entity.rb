# frozen_string_literal: true

module TabcSi
  module Entities
    class InspectionEntity < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :location_id, documentation: { type: 'integer', format: 'int64' }

      expose :permit_name do |object|
        object.audit_form.permit_name
      end

      expose :started_at, documentation: { format: 'date-time' }
      expose :created_at, documentation: { format: 'date-time' }
      expose :completed_at, documentation: { format: 'date-time' }
    end
  end
end
