# frozen_string_literal: true

module TabcSi
  module Builders
    class QuestionBuilderMap < Hash
      def initialize(json)
        json.map do |question_number, config|
          store(
            question_number.to_sym,
            Builders::QuestionBuilder.new(question_number, config)
          )
        end
      end
    end
  end
end
