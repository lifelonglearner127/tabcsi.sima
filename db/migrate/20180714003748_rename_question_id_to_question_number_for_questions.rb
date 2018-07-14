class RenameQuestionIdToQuestionNumberForQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :question_id, :question_number
  end
end
