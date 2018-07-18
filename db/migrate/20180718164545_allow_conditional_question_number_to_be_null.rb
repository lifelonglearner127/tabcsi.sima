# frozen_string_literal: true

class AllowConditionalQuestionNumberToBeNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :conditions, :conditional_question_number, true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
