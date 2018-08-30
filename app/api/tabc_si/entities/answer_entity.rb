# frozen_string_literal: true

module TabcSi
  module Entities
    class AnswerEntity < Grape::Entity
      expose :value
      expose :question, using: QuestionEntity
      expose :photos, using: PhotoEntity
    end
  end
end
