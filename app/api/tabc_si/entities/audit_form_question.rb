# frozen_string_literal: true

module TabcSi
  module Entities
    class AuditFormQuestion < Grape::Entity
      expose :question_number, as: :question_id
      expose :question_text
      expose :question_type, as: :type
      expose :max_characters
      expose :multiline
      expose :source
      expose :other
      expose :multiple, documentation: { type: 'boolean' }
      expose :choices, using: Entities::Choice
      expose :conditions, using: Entities::Condition
    end
  end
end
