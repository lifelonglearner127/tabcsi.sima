# frozen_string_literal: true

NUMBER_OF_RELEASES_TO_KEEP = 5
NUMBER_OF_BUNDLE_JOBS = 4
# NUMBER_OF_BOX_SYNC_WORKERS = 1
# NUMBER_OF_FOLDER_SYNC_WORKERS = 1
# NUMBER_OF_UPLOAD_WORKERS = 1
# NUMBER_OF_FORM_WORKERS = 1

YARN_FLAGS = %w[--production --silent --no-progress].freeze

# config valid only for current version of Capistrano
lock '~> 3.11.0'

# main settings
set :application, 'tabc-si'
set :repo_url, 'git@github.com:Neuone/TABC-Audit-Backend.git'
set :keep_releases, NUMBER_OF_RELEASES_TO_KEEP

set(
  :linked_dirs,
  %w[
    .bundle log node_modules public/system public/uploads tmp/cache tmp/pids
    tmp/sockets tmp/uploads vendor/bundle
  ]
)

set(:linked_files, %w[.env config/master.key])

# RVM
set :rvm_type, :system
set :rvm_ruby_version, File.read('.ruby-version').chomp
set(
  :rvm_map_bins,
  %w[bundle gem passenger passenger-config passenger-status rails rake ruby]
)

# NVM
# set :nvm_type, :system
# set :nvm_node, "v#{File.read('.node-version').chomp}"
# set :nvm_map_bins, %w[node npm rails yarn]

# Bundler
set :bundle_bins, %w[gem rails rake]
set :bundle_path, -> { shared_path.join('vendor', 'bundle') }
set :bundle_jobs, NUMBER_OF_BUNDLE_JOBS

after 'deploy:published', 'bundler:clean'

# Yarn
set(:yarn_flags, YARN_FLAGS)

# Rails
set :rails_env, 'production'
set :migration_role, :app

# Passenger
set :passenger_restart_with_touch, false
# set :passenger_rvm_ruby_version, '2.5.1'
# set :passenger_restart_with_sudo, true
set :passenger_in_gemfile, true
set :passenger_restart_command, -> { "#{release_path}/bin/restart" }
set :passenger_restart_options, nil

# HipChat
# set :hipchat_token, 'LhzIHa85TlY8t5gtsMpO0wxB9KkLShgmCZT0GJc9'
# set :hipchat_room_name, 'TABC SI'
# set :hipchat_options, api_version: 'v2'

# Resque
# set :resque_environment_task, true

# set(
#   :workers,
#   'sync-boxes-jobs': NUMBER_OF_BOX_SYNC_WORKERS,
#   'sync-folders-jobs': NUMBER_OF_FOLDER_SYNC_WORKERS,
#   'upload-jobs': NUMBER_OF_UPLOAD_WORKERS,
#   'f4885l-jobs': NUMBER_OF_FORM_WORKERS
# )

# after 'deploy:restart', 'resque:restart'

# Other
# set :webpack_assets_prefix, '/vbox-web'

# Failure Hook
after('deploy:failed', :remove_failed_release) do
  on roles :app do
    execute "rm -fr #{release_path}"
  end
end
