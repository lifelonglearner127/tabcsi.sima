# frozen_string_literal: true

module Faker
  class Name < Base
    class << self
      def full_name
        "#{first_name} #{last_name}"
      end
    end
  end
end
