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
  delayed_job
  scm/git
].each do |file|
  require "capistrano/#{file}"
end

require 'slackistrano/capistrano'
require_relative 'lib/capistrano/slackistrano/messaging/custom_messaging'

install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
