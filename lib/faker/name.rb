# frozen_string_literal: true

module Faker
  class Name < Base
    class << self
      def full_name
        parse('name.full_name')
      end
    end
  end
end
