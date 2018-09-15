# frozen_string_literal: true

class AddBuiltOnToQuestions < ActiveRecord::Migration[5.2]
  def up
    change_table :questions do |t|
      t.date :built_on
      t.index %i[built_on question_number], unique: true
    end

    Question.find_each do |question|
      date_offset = 0
      begin
        question.update!(built_on: question.created_at + date_offset)
      rescue ActiveRecord::RecordInvalid
        date_offset += 1.day
        retry
      end
    end
  end

  def down
    change_table :questions do |t|
      t.remove_index column: %i[built_on question_number]
      t.remove :built_on
    end
  end
end
