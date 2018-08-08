# frozen_string_literal: true

class Question28
  def run
    Question
      .find_by(question_number: '1')
      .update!(
        question_text: 'Name of person filling out survey (First & Last)'
      )

    Question
      .find_by(question_number: '7')
      .update!(question_text: 'Weapons Sign Posted')

    question28 = Question.create!(
      question_number: '28',
      question_text: <<~TEXT,
        What is the minimum age that you employ a person to sell/serve alcohol
        at your location?
      TEXT
      question_type: :radio
    )

    [
      { choice_text: '16 years old' },
      { choice_text: 'Younger than 16 years of age' },
      { choice_text: '18 years old' },
      { choice_text: '21 years old' }
    ].each do |choice_attrs|
      Choice.create!(
        question: question28,
        **choice_attrs
      )
    end

    %i[BE BE-FB BG BG-FB MB MB-FB N N-FB NB NE P Q RM V Y].each do |permit_name|
      audit_form = AuditForm.find_by(permit_name: permit_name)

      AuditFormQuestion.create!(audit_form: audit_form, question: question28)
    end
  end
end
