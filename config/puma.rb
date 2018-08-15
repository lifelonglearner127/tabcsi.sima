# frozen_string_literal: true

# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server

# The environment variable `WEB_CONCURRENCY` may be set to a default value based
# on dyno size. To manually configure this value use
# `heroku config:set WEB_CONCURRENCY`.
#
# Increasing the number of workers will increase the amount of resting memory
# your dynos use. Increasing the number of threads will increase the amount of
# potential bloat added to your dynos when they are responding to heavy
# requests.
#
# Starting with a low number of workers and threads provides adequate
# performance for most applications, even under load, while maintaining a low
# risk of overusing memory.
workers Integer(Nenv.instance.web_concurrency || 2)

thread_count = Integer(Nenv.instance.max_threads || 2)
threads(thread_count, thread_count)

preload_app!

rackup DefaultRackup
environment Nenv.instance.rack_env || 'development'

port Nenv.instance.port

on_worker_boot do
  # Worker specific setup for Rails 4.1+. See:
  # https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
