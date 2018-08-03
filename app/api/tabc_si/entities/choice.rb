# frozen_string_literal: true

module TabcSi
  module Entities
    class Choice < Grape::Entity
      expose(
        :id,
        documentation: {
          desc: 'A unique identifier for choice tracking.',
          type: 'integer',
          format: 'int64'
        }
      )

      expose(
        :choice_text,
        as: :text,
        documentation: { desc: 'The choice text.' }
      )

      expose(
        :picture_attachment,
        documentation: {
          desc: 'If `true`, then a picture is required to be included.',
          type: 'boolean'
        }
      )

      expose(
        :fields,
        using: Entities::Field,
        documentation: { is_array: true }
      )
    end
  end
end
