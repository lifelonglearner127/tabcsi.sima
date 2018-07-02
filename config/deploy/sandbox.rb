# frozen_string_literal: true

set :deploy_to, "/srv/www/rails/#{fetch(:application)}"
set :branch, 'develop'

server(
  '54.83.35.192',
  user: 'tabcsi',
  roles: %w[app db web resque_worker resque_scheduler]
)
