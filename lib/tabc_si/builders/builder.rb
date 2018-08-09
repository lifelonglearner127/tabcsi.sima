# frozen_string_literal: true

module TabcSi
  module Builders
    class Builder
      attr_reader :attributes
      attr_reader :config

      def initialize(config = {})
        @attributes = {}
        @config = config.is_a?(Hash) ? config.with_indifferent_access : config

        parse_config
      end

      def build
        raise NotImplementedError, 'build method not implemented'
      end

      protected

      def parse_config(config_keys = [])
        @attributes = config.slice(*config_keys).deep_symbolize_keys
      end
    end
  end
end
