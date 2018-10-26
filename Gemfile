# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

gem 'bootsnap', '~> 1.3', require: false
gem 'delayed_job_active_record', '~> 4.1'
gem 'devise', '~> 4.4'
gem 'devise-doorkeeper', '~> 1.1'
gem 'discard', '~> 1.0'
gem 'doorkeeper', '~> 5.0'
gem 'dotenv-rails', '~> 2.5'
gem 'fcm-ruby-push-notifications', '~> 1.2'
gem 'flutie', '~> 2.1'
gem 'grape', '~> 1.0'
gem 'grape-entity', '~> 0.7.1'
gem 'grape-swagger', '~> 0.31.1'
gem 'grape-swagger-entity', '~> 0.3.0'
gem 'grape_logging', '~> 1.8'
gem 'high_voltage', '~> 3.1'
gem 'kramdown', '~> 1.17'
gem 'nenv', '~> 0.3.0'
gem 'nokogiri', '~> 1.8'
gem 'oj', '~> 3.6'
gem 'pg', '~> 1.1'
gem 'premailer-rails', '~> 1.10'
gem 'puma', '~> 3.11'
gem 'rack-attack', '~> 5.4'
gem 'rack-cors', '~> 1.0'
gem 'rails', '~> 5.2.1'
gem 'simple_form', '~> 4.0'
gem 'slim-rails', '~> 3.2'
gem 'title', '~> 0.0.7'
gem 'tzinfo-data', '~> 1.2018'
gem 'uglifier', '~> 4.1'
gem 'webpacker', '~> 4.0.0.pre.3'

group :development do
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-passenger', '~> 0.2.0', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm', '~> 0.1.2', require: false
  gem 'listen', '~> 3.1.5'
  gem 'rack-mini-profiler', '~> 1.0', require: false
  gem 'rubocop', '~> 0.60.0', require: false
  gem 'rubocop-rspec', '~> 1.30'
  gem 'slackistrano', '~> 3.8'
  gem 'spring', '~> 2.0'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-watcher-listen', '~> 2.0'
  gem 'web-console', '~> 3.7'
end

group :development, :test do
  gem 'awesome_print', '~> 1.8'
  gem 'bullet', '~> 5.7'
  gem 'bundler-audit', '~> 0.6.0', require: false
  gem 'factory_bot_rails', '~> 4.11'
  gem 'faker', '~> 1.9'
  gem 'pry-byebug', '~> 3.6'
  gem 'pry-rails', '~> 0.3.6'
  gem 'rspec-rails', '~> 3.8'
end

group :test do
  gem 'capybara', '~> 3.10'
  gem 'formulaic', '~> 0.4.0'
  gem 'phantomjs', '~> 2.1'
  gem 'poltergeist', '~> 1.18'
  gem 'simplecov', '~> 0.16.1', require: false
  gem 'timecop', '~> 0.9.1'
  gem 'webmock', '~> 3.4'
end

group :production do
  gem 'aws-sdk-rails', '~> 2.0'
  gem 'aws-sdk-s3', '~> 1.23'
  gem 'passenger', '~> 5.3'
  gem 'rack-timeout', '~> 0.5.1'
end
