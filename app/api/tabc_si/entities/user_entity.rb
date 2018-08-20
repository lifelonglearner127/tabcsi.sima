# frozen_string_literal: true

module TabcSi
  module Entities
    class UserEntity < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :full_name
      expose :job_title
      expose :email
      expose :phone
    end
  end
end
