# frozen_string_literal: true

module TabcSi
  module Entities
    class SettingEntity < Grape::Entity
      expose :name, documentation: { desc: 'The name of the setting.' }
      expose :value, documentation: { desc: 'The value of the setting.' }
    end
  end
end
