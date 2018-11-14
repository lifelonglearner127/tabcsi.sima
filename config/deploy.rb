# frozen_string_literal: true

NUMBER_OF_RELEASES_TO_KEEP = 5
NUMBER_OF_BUNDLE_JOBS = 2
DELAYED_JOB_POOLS = {
  nil => 1,
  imports: 1,
  news: 1,
  reports: 1
}

# config valid only for current version of Capistrano
lock '~> 3.11'

# main settings
set :application, 'tabc-si'
set :repo_url, 'git@github.com:Neuone/TABC-Audit-Backend.git'
set :keep_releases, NUMBER_OF_RELEASES_TO_KEEP

set(
  :linked_dirs,
  %w[
    .bundle log node_modules public/packs public/system public/uploads tmp/cache
    tmp/pids tmp/sockets tmp/uploads vendor/bundle
  ]
)

set(:linked_files, %w[.env config/master.key apns.pem])

# RVM
set :rvm_type, :system
set :rvm_ruby_version, File.read('.ruby-version').chomp
set(
  :rvm_map_bins,
  %w[bundle gem passenger passenger-config passenger-status rails rake ruby]
)

# Bundler
set :bundle_bins, %w[gem rails rake]
set :bundle_path, -> { shared_path.join('vendor', 'bundle') }
set :bundle_jobs, NUMBER_OF_BUNDLE_JOBS

# Rails
set :rails_env, 'production'
set :migration_role, :app

# Passenger
set :passenger_restart_with_touch, false
set :passenger_in_gemfile, true
set :passenger_restart_command, -> { "#{release_path}/bin/restart" }
set :passenger_restart_options, nil

# Slack
set(
  :slackistrano,
  klass: Slackistrano::Messaging::CustomMessaging,
  channel: '#tabc-si',
  webhook: 'https://hooks.slack.com/services/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'
)

# Delayed Job
set :delayed_job_prefix, 'tabc_cr'
set :delayed_job_pools, DELAYED_JOB_POOLS
set :delayed_job_monitor, true

# after 'deploy:set_current_revision', 'tabc_si:set_mtimes'
after 'deploy:published', 'bundler:clean'
after 'deploy:failed', 'tabc_si:remove_current_release'
