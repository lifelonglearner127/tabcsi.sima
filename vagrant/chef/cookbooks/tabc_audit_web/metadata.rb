# frozen_string_literal: true

name 'tabc_audit_web'
maintainer 'The Authors'
maintainer_email 'jpickwell@neuone.com'
license 'All Rights Reserved'
description 'Installs/Configures tabc_audit_web'
long_description 'Installs/Configures tabc_audit_web'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)
supports 'ubuntu', '>= 16.04'
depends 'nginx', '~> 8.1.2'
depends 'nodejs', '~> 5.0.0'
depends 'postgresql', '~> 7.1.0'
depends 'ruby_rbenv', '~> 2.0.9'
depends 'server_base'
depends 'yarn', '~> 0.4.0'
