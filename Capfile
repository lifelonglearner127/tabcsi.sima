# frozen_string_literal: true

require 'dotenv/load'
require 'nenv'

unless ENV['RAILS_ENV'] == 'production'
  begin
    require 'pry-byebug'
  rescue StandardError # rubocop:disable Lint/HandleExceptions
  end
end

%w[
  setup
  deploy
  bundler
  passenger
  rails
  rvm
  scm/git
].each do |file|
  require "capistrano/#{file}"
end

require 'slackistrano/capistrano'
# require 'capistrano-resque'

install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
