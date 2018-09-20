# frozen_string_literal: true

set :deploy_to, "/srv/www/rails/#{fetch(:application)}"
set :branch, 'master'

server(
  'ec2-52-61-205-129.us-gov-west-1.compute.amazonaws.com',
  user: 'tabcsi',
  roles: %w[app db web resque_worker resque_scheduler]
)
