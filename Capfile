# frozen_string_literal: true

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
  yarn
].each do |file|
  require "capistrano/#{file}"
end

# require 'hipchat/capistrano'
# require 'capistrano-resque'

install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
