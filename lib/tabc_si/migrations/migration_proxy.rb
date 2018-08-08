# frozen_string_literal: true

module TabcSi
  module Migrations
    MigrationProxy = Struct.new(:name, :version, :file_name) do
      def initialize(name, version, file_name)
        super

        @migration = nil
      end

      delegate :run, to: :migration

      private

      def migration
        @migration ||= load_migration
      end

      def load_migration
        require(File.expand_path(file_name))
        name.constantize.new
      end
    end
  end
end
