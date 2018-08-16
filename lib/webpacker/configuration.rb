# frozen_string_literal: true

module Webpacker
  class Configuration
    private

    def load
      Rails.application.config_for(config_path).with_indifferent_access
    rescue Errno::ENOENT => e
      raise(
        "Webpacker configuration file not found #{config_path}. Please run " \
        "`rails webpacker:install`. Error: #{e.message}"
      )
    end
  end
end
