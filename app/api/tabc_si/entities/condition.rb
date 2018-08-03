# frozen_string_literal: true

module TabcSi
  module Entities
    class Condition < Grape::Entity
      expose(
        :conditional_question_number,
        as: :conditional_question_id,
        documentation: {
          desc: <<~DESC
            The question number (`question_id`) to jump to, if this condition is
            met/triggered.
          DESC
        }
      )

      expose(
        :condition_value,
        documentation: {
          desc: 'The choice text or value that meets/triggers this condition.'
        }
      )
    end
  end
end
