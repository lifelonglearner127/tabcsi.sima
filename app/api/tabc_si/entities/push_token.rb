# frozen_string_literal: true

module TabcSi
  module Entities
    class PushToken < Grape::Entity
      expose :user_id
      expose :device_type
      expose :token
    end
  end
end
