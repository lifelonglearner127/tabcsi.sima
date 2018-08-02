# frozen_string_literal: true

module TabcSi
  module Entities
    class AuditFormQuestion < Grape::Entity
      expose :question_number, as: :question_id
      expose :question_text
      expose :question_type, as: :type
      expose :max_characters, documentation: { type: 'integer' }
      expose :multiline, documentation: { type: 'boolean' }
      expose :source
      expose :other, documentation: { type: 'integer' }
      expose :multiple, documentation: { type: 'boolean' }

      expose(
        :choices,
        using: Entities::Choice,
        documentation: { is_array: true }
      )

      expose(
        :conditions,
        using: Entities::Condition,
        documentation: { is_array: true }
      )
    end
  end
end
