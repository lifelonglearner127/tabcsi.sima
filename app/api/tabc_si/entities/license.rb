# frozen_string_literal: true

module TabcSi
  module Entities
    class License < Grape::Entity
      expose :license_type, as: :type
      expose :license_number, as: :number
      expose :subordinate
      expose :related_to
      expose :license_status
      expose :expires_on, documentation: { format: 'date' }
    end
  end
end
