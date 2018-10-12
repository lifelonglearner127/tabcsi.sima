# frozen_string_literal: true

namespace :test do
  desc 'Test APNS'
  task(:apns, %i[token] => :environment) do |_task, args|
    token = args[:token]
    message = {
      id: 0,
      subject: 'APNS Test Subject',
      created_at: Time.zone.now,
      link: 'https://www.apple.com/'
    }

    result = TabcSi::PushManagers::ApnsManager.new.send([token], message)

    puts(result ? 'Successful' : 'Failed')
  end

  desc 'Test FCM'
  task(:fcm, %i[token] => :environment) do |_task, args|
    token = args[:token]
    message = {
      id: 0,
      subject: 'FCM Test Subject',
      created_at: Time.zone.now,
      link: 'https://www.google.com/'
    }

    result = TabcSi::PushManagers::FcmManager.new.send([token], message)

    puts(result ? 'Successful' : 'Failed')
  end
end
