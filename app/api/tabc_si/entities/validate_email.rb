# frozen_string_literal: true

module TabcSi
  module Entities
    class ValidateEmail < Grape::Entity
      expose(
        :valid_email,
        documentation: {
          type: 'boolean',
          desc: 'Whether or not the specified `email` exists in the system.'
        }
      )
    end
  end
end
