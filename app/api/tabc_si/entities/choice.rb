# frozen_string_literal: true

module TabcSi
  module Entities
    class Choice < Grape::Entity
      expose :id, documentation: { type: 'integer', format: 'int64' }
      expose :choice_text, as: :text
      expose :picture_attachment, documentation: { type: 'boolean' }

      expose(
        :fields,
        using: Entities::Field,
        documentation: { is_array: true }
      )
    end
  end
end
