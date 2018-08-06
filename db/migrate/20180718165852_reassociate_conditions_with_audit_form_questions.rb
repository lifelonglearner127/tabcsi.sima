# frozen_string_literal: true

class ReassociateConditionsWithAuditFormQuestions < ActiveRecord::Migration[5.2]
  def up
    add_reference(
      :conditions, :audit_form_question, foreign_key: true, index: true
    )
    change_column_null :conditions, :question_id, true

    if Question.first.respond_to?(:conditions)
      Question
        .includes(:conditions, :audit_form_questions)
        .all
        .each do |question|
        question.audit_form_questions.each do |audit_form_question|
          question.conditions.each do |condition|
            Condition.create!(
              audit_form_question: audit_form_question,
              condition_value: condition.condition_value,
              conditional_question_number: condition.conditional_question_number
            )
          end
        end

        question.conditions.each(&:destroy)
      end
    end

    change_column_null :conditions, :audit_form_question_id, false
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
