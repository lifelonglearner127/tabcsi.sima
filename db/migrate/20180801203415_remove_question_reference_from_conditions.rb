# frozen_string_literal: true

class RemoveQuestionReferenceFromConditions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :conditions, :question, foreign_key: true, index: true
  end
end
