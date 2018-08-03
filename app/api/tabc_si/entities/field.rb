# frozen_string_literal: true

module TabcSi
  module Entities
    class Field < Grape::Entity
      expose :label, documentation: { desc: 'The field text.' }

      expose(
        :field_type,
        as: :type,
        documentation: {
          desc: <<~DESC,
            * `time_range` Two time selection boxes that allow specifying a time
              range; e.g., open-close times.
          DESC
          values: ::Field.field_types.keys
        }
      )
    end
  end
end
