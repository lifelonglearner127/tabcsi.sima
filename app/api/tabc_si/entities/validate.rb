# frozen_string_literal: true

module TabcSi
  module Entities
    class Validate < Grape::Entity
      expose(
        :valid_email,
        documentation: {
          type: 'boolean',
          desc: 'Whether or not the specified `email` exists in the system.'
        }
      )

      expose(
        :valid_location,
        safe: true,
        documentation: {
          type: 'boolean',
          desc: 'Whether or not the specified `location_id` is valid for the' \
            ' specified `email`. Will be `null` if `location_id` is not' \
            ' specified.'
        }
      )
    end
  end
end
