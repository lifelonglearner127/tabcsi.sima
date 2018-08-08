# frozen_string_literal: true

namespace :admin do
  desc 'Activate the server'
  task activate: :environment do
    if Setting.server_active?
      puts 'Server is already activated.'

      return
    end

    Setting.server_status = :active
  end

  desc 'Deactivate the server'
  task deactivate: :environment do
    unless Setting.server_active?
      puts 'Server is already deactivated.'

      return
    end

    Setting.server_status = :inactive
  end

  desc 'Load TABC data feed'
  task data_feed: :environment do
    TabcSi::DataFeed.load(Rails.root.join('lib', 'sample_data_feed.csv'))
  end

  desc 'Run migration script'
  task(:migrations, %i[version] => :environment) do |_task, args|
    version = args[:version]

    TabcSi::MigrationRunner.migrate(version)
  end

  desc 'Load settings'
  task load_settings: :environment do
    TabcSi::SettingsLoader.run
  end
end
