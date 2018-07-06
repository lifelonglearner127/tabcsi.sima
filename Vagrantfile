# frozen_string_literal: true

require 'json'

def transform_keys!(hash, &block)
  return hash.transform_keys!(&block) if hash.respond_to?(:transform_keys!)
  return hash if hash.empty?

  pairs = hash.flatten

  hash.clear

  pairs.each_slice(2) do |key, value|
    new_key = yield key
    hash[new_key] = value
  end

  hash
end

def deep_symbolize_keys!(hash)
  transform_keys!(hash, &:to_sym)

  hash.transform_values! do |value|
    if value.is_a?(Hash)
      deep_symbolize_keys!(value)
    else
      value
    end
  end

  hash
end

VAGRANT_CONFIG = deep_symbolize_keys!(
  JSON.parse(File.read('vagrant/config.json'))
)

PROJECT_NAME = VAGRANT_CONFIG[:name]
PROJECT_KEY = VAGRANT_CONFIG[:key]
REQUIRED_PLUGINS = VAGRANT_CONFIG[:plugins]
VIRTUAL_BOX_CONFIG = VAGRANT_CONFIG[:virtual_box]

plugins_to_install =
  REQUIRED_PLUGINS.reject do |plugin|
    Vagrant.has_plugin?(plugin)
  end

unless plugins_to_install.empty?
  plugins = plugins_to_install.join(' ')

  puts "Installing required plugins: #{plugins}"

  # FIXME: this is broken
  if system("vagrant plugin install #{plugins}")
    exec("vagrant #{ARGV.join(' ')}")
  else
    abort(
      'Installation of one or more plugins failed. Aborting. Please read'\
      ' `README.md`.'
    )
  end
end

def config_virtual_box(config, box_name)
  config.vm.provider(:virtualbox) do |vb|
    memory = VIRTUAL_BOX_CONFIG[:memory]
    cpus = VIRTUAL_BOX_CONFIG[:cpus]
    options = VIRTUAL_BOX_CONFIG[:options]

    vb.name = box_name

    options.each do |opt_name, opt_value|
      vb.customize(['modifyvm', :id, "--#{opt_name}", opt_value])
    end

    vb.memory = memory if memory
    vb.cpus = cpus if cpus
  end
end

def define_box(config, name, box_config)
  config.vm.define(name) do |box|
    box_name = "#{PROJECT_KEY}-#{name}"
    host_name = "#{box_name}.local"

    config_virtual_box(config, box_name)

    box_config[:synced_folders]&.each do |host, guest|
      box.vm.synced_folder(host, guest)
    end

    box.vm.hostname = host_name

    box.vm.network(:private_network, ip: box_config[:private_ip])

    box.hostmanager.aliases = %W[www.#{host_name}]

    box_config[:ports]&.each do |id, ports|
      box.vm.network(
        :forwarded_port,
        guest: ports[:guest],
        host: ports[:host],
        id: id
      )
    end

    box.vm.provision :hostmanager

    box.vm.provision(:chef_solo) do |chef|
      chef.add_recipe("#{PROJECT_NAME}_#{name}")

      box_config[:chef][:recipes].each { |recipe| chef.add_recipe(recipe) }
    end

    scripts = box_config[:scripts]
    scripts = [scripts] unless scripts.is_a?(Array)
    scripts.each do |script|
      box.vm.provision(:shell, path: script) if script
    end
  end
end

def define_boxes(config, boxes)
  boxes.each do |name, box_config|
    define_box(config, name, box_config)
  end
end

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-16.04'

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  define_boxes(config, VAGRANT_CONFIG[:boxes])
end
