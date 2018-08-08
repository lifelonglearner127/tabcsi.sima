# frozen_string_literal: true

namespace :doorkeeper do
  desc 'Create new Doorkeeper app.'
  task(:application, %i[name] => :environment) do |_task, args|
    application_params = {
      name: args[:name],
      redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
    }

    application = Doorkeeper::Application.new(application_params)
    application.save

    puts "App Name: #{application.name}"
    puts "App Id: #{application.uid}"
    puts "App Secret: #{application.secret}"
  end
end
