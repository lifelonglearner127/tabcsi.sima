# frozen_string_literal: true

module TabcSi
  module Migrations
    class MigrationRunner
      include Singleton

      MIGRATION_FILENAME_REGEXP = /\A([0-9]+)-([^.]+)\.rb\z/

      attr_accessor :version

      def self.migrate(version)
        instance.migrate(version)
      end

      def migrate(version)
        self.version = version

        migrations.each(&:run)
      end

      private

      def migrations_path
        @migrations_path ||= Rails.root.join('db', 'migrations')
      end

      def migration_files
        file_glob = version.present? ? "#{date}-*.rb" : '[0-9]*-*.rb'

        Dir["#{migrations_path}/#{file_glob}"]
      end

      def migrations
        @migrations ||= map_migrations
      end

      def map_migrations
        migrations = migration_files.map do |file_name|
          version, name = parse_migration_file_name(file_name)
          name = name.camelize

          MigrationProxy.new(name, version, file_name)
        end

        migrations.sort_by(&:version)
      end

      def parse_migration_file_name(file_name)
        File.basename(file_name).scan(MIGRATION_FILENAME_REGEXP).first
      end
    end
  end
end
