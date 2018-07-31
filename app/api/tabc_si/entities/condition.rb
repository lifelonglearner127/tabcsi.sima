# frozen_string_literal: true

module TabcSi
  module Entities
    class Condition < Grape::Entity
      expose :conditional_question_number, as: :conditional_question_id
      expose :condition_value
    end
  end
end
