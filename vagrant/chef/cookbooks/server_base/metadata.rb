# frozen_string_literal: true

name 'server_base'
maintainer 'The Authors'
maintainer_email 'jpickwell@neuone.com'
license 'MIT'
description 'Installs/Configures server_base'
long_description 'Installs/Configures server_base'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)
supports 'ubuntu', '>= 16.04'
depends 'apt', '~> 7.0.0'
depends 'build-essential', '~> 8.1.1'
depends 'os-hardening', '~> 3.1.0'
depends 'system', '~> 0.11.3'
depends 'vim', '~> 2.0.2'
