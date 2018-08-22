# frozen_string_literal: true

module TabcSi
  module Entities
    class LicenseEntity < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :license_type, as: :type
      expose :license_number, as: :number
      expose :subordinate
      expose :related_to
      expose :status
      expose :expires_on, documentation: { format: 'date' }
    end
  end
end
