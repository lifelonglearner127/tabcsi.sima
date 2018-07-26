# frozen_string_literal: true

namespace :admin do
  desc 'Activate the server.'
  task activate: :environment do
    if Setting.server_active?
      puts 'Server is already activated.'

      return
    end

    Setting.server_status = :active
  end

  desc 'Deactivate the server.'
  task deactivate: :environment do
    unless Setting.server_active?
      puts 'Server is already deactivated.'

      return
    end

    Setting.server_status = :inactive
  end
end
