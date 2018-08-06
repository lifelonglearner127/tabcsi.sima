# frozen_string_literal: true

module TabcSi
  module Entities
    class PushTokenEntity < Grape::Entity
      expose :user_id, documentation: { type: 'integer', format: 'int64' }

      expose(
        :device_type,
        documentation: { values: PushToken.device_types.keys }
      )

      expose :token
    end
  end
end
