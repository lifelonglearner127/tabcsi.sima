# frozen_string_literal: true

def read_ruby_version_file(path)
  ruby_version_file_path = File.join(path, '.ruby-version')
  puts ruby_version_file_path
  if File.exist?(ruby_version_file_path)
    return File.read(ruby_version_file_path).chomp
  end

  return nil if path == '/'

  read_ruby_version_file(File.absolute_path(File.join(path, '..')))
end

def get_ruby_version(fallback = '2.5.1')
  read_ruby_version_file(__dir__) || fallback
end

default['system']['packages']['install'] = %w[
  apt-transport-https
  ca-certificates
  dirmngr
  gnupg
  gstreamer1.0-plugins-base
  gstreamer1.0-tools
  gstreamer1.0-x
  libcurl4-openssl-dev
  libpcre2-dev
  libpcre3-dev
  libqt5webkit5-dev
  qt5-default
]

default['nodejs']['repo'] = 'https://deb.nodesource.com/node_8.x'

# rubocop:disable Metrics/LineLength
# default['nginx']['install_method'] = 'source'
# default['nginx']['version'] = '1.14.0'
# default['nginx']['default']['modules'] = %w[passenger]
# default['nginx']['source']['version'] = node['nginx']['version']
# default['nginx']['source']['prefix'] =
#   "/opt/nginx-#{node['nginx']['source']['version']}"
# default['nginx']['source']['sbin_path'] =
#   "#{node['nginx']['source']['prefix']}/sbin/nginx"
# default['nginx']['source']['default_configure_flags'] = %W[
#   --prefix=#{node['nginx']['source']['prefix']}
#   --conf-path=#{node['nginx']['dir']}/nginx.conf
#   --sbin-path=#{node['nginx']['source']['sbin_path']}
#   --with-cc-opt=-Wno-error
# ]
# default['nginx']['source']['url'] =
#   "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
# default['nginx']['source']['checksum'] =
#   '5d15becbf69aba1fe33f8d416d97edd95ea8919ea9ac519eff9bafebb6022cb5'
# default['nginx']['source']['modules'] = %w[
#   nginx::http_gzip_static_module
#   nginx::http_ssl_module
#   nginx::passenger
# ]
# default['nginx']['passenger']['version'] = '5.3.3'
# default['nginx']['passenger']['install_method'] =
#   node['nginx']['install_method']
# default['nginx']['passenger']['root'] = ''
# default['nginx']['passenger']['ruby'] = ''
# rubocop:enable Metrics/LineLength

default['taw']['psql_version'] = '10'
default['taw']['ruby_version'] = get_ruby_version
default['taw']['nginx']['cc_opts'] = %w[
  -O2
  -fstack-protector-strong
  -Wformat
  -Werror=format-security
  -Wp,-D_FORTIFY_SOURCE=2
]
default['taw']['nginx']['ld_opts'] = %w[
  -Wl,-Bsymbolic-functions
  -Wl,-z,relro
  -Wl,-z,now
  -Wl,--as-needed
]
default['taw']['nginx']['sbin_path'] = '/usr/sbin/nginx'
default['taw']['nginx']['error_log_path'] = '/var/log/nginx/error.log'
default['taw']['nginx']['access_log_path'] = '/var/log/nginx/access.log'
default['taw']['nginx']['pid_path'] = '/var/run/nginx.pid'
default['taw']['nginx']['client_temp_path'] = '/var/cache/nginx/client_temp'
default['taw']['nginx']['proxy_temp_path'] = '/var/cache/nginx/proxy_temp'
default['taw']['nginx']['fastcgi_temp_path'] = '/var/cache/nginx/fastcgi_temp'
default['taw']['nginx']['uwsgi_temp_path'] = '/var/cache/nginx/uwsgi_temp'
default['taw']['nginx']['scgi_temp_path'] = '/var/cache/nginx/scgi_temp'
default['taw']['nginx']['configure_flags'] = %W[
  --sbin-path=#{node['taw']['nginx']['sbin_path']}
  --modules-path=/usr/lib/nginx/modules
  --conf-path=/etc/nginx/nginx.conf
  --error-log-path=#{node['taw']['nginx']['error_log_path']}
  --http-log-path=#{node['taw']['nginx']['access_log_path']}
  --pid-path=#{node['taw']['nginx']['pid_path']}
  --lock-path=/var/run/nginx.lock
  --http-client-body-temp-path=#{node['taw']['nginx']['client_temp_path']}
  --http-proxy-temp-path=#{node['taw']['nginx']['proxy_temp_path']}
  --http-fastcgi-temp-path=#{node['taw']['nginx']['fastcgi_temp_path']}
  --http-uwsgi-temp-path=#{node['taw']['nginx']['uwsgi_temp_path']}
  --http-scgi-temp-path=#{node['taw']['nginx']['scgi_temp_path']}
  --user=nginx
  --group=nginx
  --with-compat
  --with-file-aio
  --with-threads
  --with-http_auth_request_module
  --with-http_dav_module
  --with-http_flv_module
  --with-http_gunzip_module
  --with-http_mp4_module
  --with-http_random_index_module
  --with-http_secure_link_module
  --with-http_slice_module
  --with-http_sub_module
  --with-mail
  --with-mail_ssl_module
  --with-stream
  --with-stream_realip_module
  --with-stream_ssl_module
  --with-stream_ssl_preread_module
  --with-cc-opt='#{node['taw']['nginx']['cc_opts'].join(' ')}'
  --with-ld-opt='#{node['taw']['nginx']['ld_opts'].join(' ')}'
]
default['taw']['passenger']['module_install_flags'] = %W[
  --auto
  --prefix=/etc/nginx
  --auto-download
  --extra-configure-flags="#{node['taw']['nginx']['configure_flags'].join(' ')}"
  --languages=ruby
]
