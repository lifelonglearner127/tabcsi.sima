# frozen_string_literal: true

module Rails
  class Application < Engine
    # Add support for 'shared' config.
    def config_for(name, env: Rails.env)
      yaml =
        if name.is_a?(Pathname)
          name
        else
          Pathname.new("#{paths['config'].existent.first}/#{name}.yml")
        end

      unless yaml.exist?
        raise "Could not load configuration. No such file - #{yaml}"
      end

      require 'erb'

      loaded_yaml = YAML.safe_load(ERB.new(yaml.read).result) || {}
      shared = loaded_yaml.delete('shared')

      if shared
        loaded_yaml.each do |_k, values|
          values.reverse_merge!(shared)
        end
      end

      Hash.new(shared).merge(loaded_yaml)[env] || {}
    rescue Psych::SyntaxError => e
      raise(
        "YAML syntax error occurred while parsing #{yaml}. Please note that" \
        ' YAML must be consistently indented using spaces. Tabs are not' \
        " allowed. Error: #{e.message}"
      )
    end
  end
end
