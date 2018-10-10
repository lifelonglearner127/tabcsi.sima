# frozen_string_literal: true

module TabcSi
  module Entities
    class NewsEntity < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :subject
      expose :created_at
      expose :link
    end
  end
end
