# frozen_string_literal: true

require 'csv'

namespace :dev do
  if Rails.env.development? || Rails.env.test?
    require 'factory_bot'

    desc 'Sample data for local development environment'
    task prime: 'db:setup' do
      include FactoryBot::Syntax::Methods

      # create(:user, email: 'user@example.com', password: 'password')
    end
  end
end
