# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  module Faker
    class Name < Base
      class << self
        def full_name
          parse('name.full_name')
        end
      end
    end
  end
end
