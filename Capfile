# frozen_string_literal: true

%w[
  setup
  deploy
  bundler
  passenger
  rails/migrations
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
