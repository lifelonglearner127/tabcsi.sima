# frozen_string_literal: true

# Cookbook:: tabc_audit_web
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'server_base'
include_recipe 'nodejs'
include_recipe 'yarn'

template '/etc/gemrc' do
  source 'gemrc.erb'
end

apt_repository 'rvm' do
  uri 'http://ppa.launchpad.net/rael-gc/rvm/ubuntu'
  components %w[main]
  deb_src true
  key 'F4E3FBBE'
end

package 'rvm'

execute 'source /etc/profile.d/rvm.sh' do
  only_if '[ -z $(which rvm) ]'
end

ruby_version = node['taw']['ruby_version']

execute "rvm install #{ruby_version} --quiet-curl --no-docs" do
  not_if "rvm list | grep #{ruby_version}"
end

execute "rvm use #{ruby_version} --default" do
  not_if "rvm alias list | grep 'default.*#{ruby_version}'"
end

execute 'rvm use default && gem install bundler' do
  not_if 'which bundle'
  user 'vagrant'
end

execute 'rvm use default && gem install rack' do
  not_if 'which rack'
  user 'vagrant'
end

# rbenv_system_install 'system'
#
# execute 'chgrp -R staff /usr/local/rbenv'
# execute 'chmod -R g+rwxXs /usr/local/rbenv'
#
# rbenv_ruby ruby_version
# rbenv_global ruby_version
#
# directory '/usr/local/rbenv/versions/2.5.1/etc'
#
# link '/usr/local/rbenv/versions/2.5.1/etc/gemrc' do
#   to '/etc/gemrc'
# end
#
# rbenv_gem 'bundler' do
#   rbenv_version ruby_version
# end
#
# rbenv_gem 'rack' do
#   rbenv_version ruby_version
# end
#
# rbenv_rehash 'rehash'

# psql_version = node['taw']['psql_version']
#
# postgresql_server_install 'PostgreSQL Server Install' do
#   version psql_version
#   password nil
# end
#
# package "postgresql-server-dev-#{psql_version}"
#
# apt_repository 'passenger' do
#   uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
#   components %w[main]
#   key '561F9B9CAC40B2F7'
# end
#
# package 'passenger'
#
# template '/tmp/pmcc' do
#   source 'passenger_module_config_cache.erb'
# end
#
# module_install_flags =
#   node['taw']['passenger']['module_install_flags'].join(' ')
#
# execute 'passenger-install-nginx-module' do
#   not_if 'diff -aNq /tmp/pmcc /etc/passenger_module_config_cache > /dev/null'
#   command "passenger-install-nginx-module #{module_install_flags}"
#   notifies :create, 'template[/etc/passenger_module_config_cache]'
# end
#
# template '/etc/passenger_module_config_cache' do
#   source 'passenger_module_config_cache.erb'
#   action :nothing
# end
#
# user 'nginx' do
#   shell '/usr/sbin/nologin'
#   system true
# end
#
# %w[
#   client_temp_path proxy_temp_path fastcgi_temp_path uwsgi_temp_path
#   scgi_temp_path
# ].each do |path_name|
#   directory node['taw']['nginx'][path_name] do
#     recursive true
#   end
# end
#
# %w[
#   conf.d sites-available sites-enabled
# ].each do |dir|
#   directory "/etc/nginx/#{dir}"
# end
#
# execute 'rm -f /etc/nginx/*.default'
#
# systemd_unit 'nginx.service' do
#   content(
#     Unit: {
#       Description: 'A high performance web server and a reverse proxy server.',
#       After: 'network.target'
#     },
#     Service: {
#       Type: 'forking',
#       PIDFile: node['taw']['nginx']['pid_path'],
#       ExecStartPre: "#{node['taw']['nginx']['sbin_path']} -t -q -g" \
#         " 'daemon on; master_process on;'",
#       ExecStart: "#{node['taw']['nginx']['sbin_path']} -g" \
#         " 'daemon on; master_process on;'",
#       ExecReload: "#{node['taw']['nginx']['sbin_path']} -g" \
#         " 'daemon on; master_process on;' -s reload",
#       ExecStop: '-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5' \
#         " --pidfile #{node['taw']['nginx']['pid_path']}",
#       TimeoutStopSec: 5,
#       KillMode: 'mixed'
#     },
#     Install: {
#       WantedBy: 'multi-user.target'
#     }
#   )
#
#   action %i[create start enable]
# end
#
# %w[
#   nginx.conf proxy_params conf.d/passenger.conf
# ].each do |file|
#   template "/etc/nginx/#{file}" do
#     source "nginx/#{file}.erb"
#     notifies :restart, 'systemd_unit[nginx.service]'
#   end
# end
#
# execute "echo 'cd /vagrant' >> /home/vagrant/.bashrc" do
#   not_if "grep -q 'cd /vagrant' /home/vagrant/.bashrc"
# end
#
# execute 'bundle install' do
#   not_if 'bundle check', cwd: '/vagrant', user: 'vagrant'
#   cwd '/vagrant'
#   user 'vagrant'
# end
#
# execute 'yarn install' do
#   not_if 'yarn check', cwd: '/vagrant'
#   cwd '/vagrant'
# end
#
# execute 'bundle exec rails db:setup' do
#   cwd '/vagrant'
# end
#
# template '/etc/nginx/sites-available/tabc-si.conf' do
#   source 'nginx/sites-available/tabc-si.conf.erb'
# end
#
# link '/etc/nginx/sites-enabled/tabc-si' do
#   to '/etc/nginx/sites-available/tabc-si.conf'
#   notifies :restart, 'systemd_unit[nginx.service]'
# end
