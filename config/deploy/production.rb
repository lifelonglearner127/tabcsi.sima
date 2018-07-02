# frozen_string_literal: true

set :deploy_to, "/srv/www/rails/#{fetch(:application)}"
set :branch, 'master'

server(
  '?',
  user: 'tabcsi',
  roles: %w[app db web resque_worker resque_scheduler]
)
