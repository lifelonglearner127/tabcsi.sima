# frozen_string_literal: true

module TabcSi
  module Entities
    class QuestionEntity < Grape::Entity
      expose :question_number, as: :number
      expose :question_text, as: :text
    end
  end
end
