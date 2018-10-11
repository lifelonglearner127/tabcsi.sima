# frozen_string_literal: true

namespace :admin do
  desc 'Activate the server'
  task activate: :environment do
    if Setting.server_active?
      puts 'Server is already activated.'

      next
    end

    Setting.activate_server!
  end

  desc 'Deactivate the server'
  task deactivate: :environment do
    unless Setting.server_active?
      puts 'Server is already deactivated.'

      next
    end

    Setting.deactivate_server!
  end

  desc 'Load TABC data feed'
  task data_feed: :environment do
    TabcSi::DataFeed.load(Rails.root.join('lib', 'NEUBUS_TABC_CR_FY.TXT'))
  end

  desc 'Load settings'
  task load_settings: :environment do
    TabcSi::SettingsLoader.run
  end

  desc 'Build audit forms'
  task build_forms: :environment do
    TabcSi::FormsBuilder.run
  end

  desc 'Create TABC admin'
  task(
    :create_tabc_admin,
    %i[full_name email phone job_title] => :environment
  ) do |_task, args|
    full_name = args[:full_name]
    email = args[:email]
    phone = args[:phone]
    job_title = args[:job_title]

    if full_name.blank?
      puts 'Full name is required.'

      next
    end

    if email.blank?
      puts 'Email is required.'

      next
    end

    phone = nil if phone.blank?
    job_title = nil if job_title.blank?

    User.create!(
      full_name: full_name,
      email: email,
      phone: phone,
      job_title: job_title,
      role: :tabc
    )

    puts "#{full_name} <#{email}> added as TABC admin."
  end
end
