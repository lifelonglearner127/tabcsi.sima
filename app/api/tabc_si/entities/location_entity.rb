# frozen_string_literal: true

module TabcSi
  module Entities
    class LocationEntity < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :name
      expose :address1
      expose :address2
      expose :address3
      expose :city
      expose :county
      expose :state
      expose :country
      expose :postal_code
      expose :phone_number
      expose :locked, documentation: { type: 'boolean' }

      expose(
        :licenses,
        using: LicenseEntity,
        documentation: { is_array: true }
      )
    end
  end
end
