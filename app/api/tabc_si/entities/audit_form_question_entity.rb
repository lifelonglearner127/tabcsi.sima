# frozen_string_literal: true

module TabcSi
  module Entities
    class AuditFormQuestionEntity < Grape::Entity
      expose(
        :question_number,
        as: :question_id,
        documentation: { desc: 'The question number.' }
      )

      expose :question_text, documentation: { desc: 'The question text.' }

      expose(
        :question_type,
        as: :type,
        documentation: {
          desc: <<~DESC,
            * `radio` A list of choices with a radio button next to each choice.
              The user can only select one choice.
            * `text_box` A text box field for the user to enter textual data.
            * `drop_down` A drop-down menu. The user can only select one choice.
          DESC
          values: Question.question_types.keys
        }
      )

      expose(
        :max_characters,
        documentation: {
          desc: <<~DESC,
            Question types: `text_box`

            The maximum number of characters the user can enter in a text box.
          DESC
          type: 'integer'
        }
      )

      expose(
        :multiline,
        documentation: {
          desc: <<~DESC,
            Question types: `text_box`

            If `true`, then the text box will appear larger, and allow line
            breaks.
          DESC
          type: 'boolean'
        }
      )

      expose(
        :source,
        documentation: {
          desc: <<~DESC,
            Question types: `drop_down`

            A URI or path indicating where the choices for a drop-down can be
            found. If a path, then it's meant to be an API path.
          DESC
        }
      )

      expose(
        :other,
        documentation: {
          desc: <<~DESC,
            Question types: `drop_down`

            If positive, then indicates the maximum number of characters for a
            special "Other" text box to be used in conjunction with the
            drop-down menu.
          DESC
          type: 'integer'
        }
      )

      expose(
        :multiple,
        documentation: {
          desc: <<~DESC,
            Question types: `radio, or drop_down`

            If `true`, then more than one choice can be selected.
          DESC
          type: 'boolean'
        }
      )

      expose(
        :label,
        documentation: {
          desc: <<~DESC
            Question types: `drop_down`

            Optional label text for the drop-down menu.
          DESC
        }
      )

      expose(
        :additional_label,
        documentation: {
          desc: <<~DESC
            Question types: `drop_down`

            Optional label text for the additional text box.
          DESC
        }
      )

      expose(
        :additional_text,
        documentation: {
          desc: <<~DESC,
            Question types: `drop_down`

            The maximum number of characters allowed in the additional text box.
          DESC
          type: 'integer'
        }
      )

      expose(
        :additional_type,
        documentation: {
          desc: <<~DESC
            Question types: `drop_down`

            The input type of the additional text box. This can either be
            interpreted as a constraint on the type of characters allowed to be
            entered into the text box, or as the type of field to be displayed
            next to the drop-down menu.

            * `number` Only numeric values are allowed.
          DESC
        }
      )

      expose(
        :choices,
        using: ChoiceEntity,
        documentation: {
          desc: 'Only valid for question types `radio` and `drop_down`.',
          is_array: true
        }
      )

      expose(
        :conditions,
        using: ConditionEntity,
        documentation: {
          desc: <<~DESC,
            Allows for conditional question skipping based on the choice or
            value of this question.
          DESC
          is_array: true
        }
      )
    end
  end
end
