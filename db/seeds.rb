# frozen_string_literal: true

QUESTION_TYPE_RADIO = Question.question_types[:radio]
QUESTION_TYPE_TEXT_BOX = Question.question_types[:text_box]

questions_map = {}

{
  '1': {
    question_text: 'Name of Person Filling Out Survey (First & Last)',
    question_type: :text_box,
    max_characters: 50
  },
  '2': {
    question_text: 'Position of person filling out survey',
    question_type: :text_box,
    max_characters: 10
  },
  '3': {
    question_text: 'Name/position of person(s) authorized to purchase alcohol' \
      ' for the business',
    question_type: :text_box,
    max_characters: 50,
    multiline: true
  },
  '4': {
    question_text: 'Is your permit posted where it can be seen by the public?',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '5': {
    question_text: 'Public Information Sign Posted',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '6': {
    question_text: 'Consumption Warning Sign Posted',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '7': {
    question_text: 'Weapons Sign Posted (Blue/Red/Both/None)',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Blue',
        picture_attachment: true
      },
      {
        choice_text: 'Red',
        picture_attachment: true
      },
      {
        choice_text: 'Both',
        picture_attachment: true
      },
      { choice_text: 'None' }
    ]
  },
  '8': {
    question_text: "Fetal Alcohol Sign Posted in Men's & Women's Restrooms",
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '9': {
    question_text: 'Human Trafficking Sign Posted',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '10': {
    question_text: '"21" To Enter Sign Posted',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '11A': {
    question_text: 'Do you have alcohol advertising on the outside of the' \
      ' business?',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '11B': {
    question_text: 'Does your business have a "Happy Hour"?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '11C': {
    question_text: 'Does your business run a "Reverse Happy Hour"?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '12': {
    question_text: 'List the vendors you purchase alcohol from',
    question_type: :text_box,
    max_characters: 100,
    multiline: true
  },
  '13A': {
    question_text: 'Are you holding any product that is damaged?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ],
    conditions: [
      {
        conditional_question_number: '14A',
        condition_value: 'No'
      }
    ]
  },
  '13B': {
    question_text: 'What product are you holding and why?',
    question_type: :text_box,
    max_characters: 100,
    multiline: true
  },
  '14A': {
    question_text: 'Is seller training required for all employees that' \
      ' sell/serve alcohol?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ],
    conditions: [
      {
        conditional_question_number: {
          %i[BE BG NB V Y] => nil,
          %i[BE-FB BG-FB] => '18',
          %i[BF BQ P Q] => '15',
          %i[MB MB-FB N N-FB NE RM] => '16'
        },
        condition_value: 'No'
      }
    ]
  },
  '14B': {
    question_text: 'If seller training is required for employees, do you have' \
      ' alcohol service policies?',
    question_type: :radio,
    choices: [
      {
        choice_text: 'Yes',
        picture_attachment: true
      },
      { choice_text: 'No' }
    ]
  },
  '15': {
    question_text: 'Do you conduct product tastings at the location?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '16': {
    question_text: 'Are TABC Stamps on ALL distilled spirit bottles?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '17': {
    question_text: "Do you mutilate the TABC Stamp on the bottle when it's" \
      ' empty?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '18': {
    question_text: 'Do you maintain food service at the location?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '19': {
    question_text: 'Is there a permanent food service facility at the' \
      ' location?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '20A': {
    question_text: 'Is the designated food service area at the location run' \
      ' by a separate business entity from the permit?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ],
    conditions: [
      {
        conditional_question_number: '21',
        condition_value: 'No'
      }
    ]
  },
  '20B': {
    question_text: 'Does the separate business entity maintain food service' \
      ' records?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '21': {
    question_text: 'Do you have multiple entrees per meal period?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '22': {
    question_text: 'Are food items completely prepared or assembled on the' \
      ' premise?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '23': {
    question_text: 'Is prepared food to be consumed on the premise?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '24A': {
    question_text: 'Are prepackaged food items sold?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ],
    conditions: [
      {
        conditional_question_number: '25A',
        condition_value: 'No'
      }
    ]
  },
  '24B': {
    question_text: 'Are prepackaged food items from a non-commercial source?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ]
  },
  '25A': {
    question_text: 'Are hours of operation for food and alcohol service the' \
      ' same?',
    question_type: :radio,
    choices: [
      { choice_text: 'Yes' },
      { choice_text: 'No' }
    ],
    conditions: [
      {
        conditional_question_number: nil,
        condition_value: 'Yes'
      }
    ]
  },
  '25B': {
    question_text: 'What are your hours of operations for both food and' \
      ' alcohol service?',
    question_type: :text_box,
    max_characters: 50
  }
}.each do |question_number, question_params|
  question = Question.find_by(question_number: question_number)
  conditions = question_params.delete(:conditions)

  if question.blank?
    choices = question_params.delete(:choices)

    question = Question.create!(
      question_number: question_number,
      **question_params
    )

    choices&.each do |choice_params|
      Choice.create!(
        question: question,
        **choice_params
      )
    end
  end

  questions_map[question_number] = {
    question: question,
    conditions: conditions
  }
end

{
  BE: %i[1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B],
  'BE-FB': %i[
    1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 18 19 20A 20B 21 22 23 24A
    24B 25A 25B
  ],
  BF: %i[1 2 3 4 5 6 7 9 11A 12 13A 13B 14A 14B 15],
  BG: %i[1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B],
  'BG-FB': %i[
    1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 18 19 20A 20B 21 22 23 24A
    24B 25A 25B
  ],
  BQ: %i[1 2 3 4 5 6 7 9 11A 12 13A 13B 14A 14B 15],
  MB: %i[1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 16 17],
  'MB-FB': %i[
    1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 16 17 18 19 20A 20B 21 22
    23 24A 24B 25A 25B
  ],
  N: %i[1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 16 17],
  'N-FB': %i[
    1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 16 17 18 19 20A 20B 21 22
    23 24A 24B 25A 25B
  ],
  NB: %i[1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B],
  NE: %i[1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 16 17],
  P: %i[1 2 3 4 5 6 7 10 11A 12 13A 13B 14A 14B 15],
  Q: %i[1 2 3 4 5 6 7 11A 12 13A 13B 14A 14B 15],
  RM: %i[
    1 2 3 4 5 7 8 9 11A 11B 11C 12 13A 13B 14A 14B 16 17 18 19 20A 20B 21 22
    23 24A 24B 25A 25B
  ],
  V: %i[1 2 3 4 5 7 8 9 12 13A 13B 14A 14B],
  Y: %i[1 2 3 4 5 7 8 9 12 13A 13B 14A 14B]
}.each do |permit_name, question_numbers|
  audit_form = AuditForm.find_by(permit_name: permit_name)
  audit_form = AuditForm.create!(permit_name: permit_name) if audit_form.blank?

  question_numbers.each do |question_number|
    question_group = questions_map[question_number]
    question = question_group[:question]
    conditions = question_group[:conditions]

    audit_form_question = AuditFormQuestion.create!(
      audit_form: audit_form,
      question: question
    )

    conditions&.each do |condition_params|
      condition_value = condition_params[:condition_value]
      conditional_question_number_param =
        condition_params[:conditional_question_number]

      conditional_question_number =
        if conditional_question_number_param.is_a?(Hash)
          key =
            conditional_question_number_param.keys.find do |qnums|
              qnums.include?(question_number)
            end

          conditional_question_number_param[key]
        else
          conditional_question_number_param
        end

      Condition.create!(
        audit_form_question: audit_form_question,
        conditional_question_number: conditional_question_number,
        condition_value: condition_value
      )
    end
  end
end
