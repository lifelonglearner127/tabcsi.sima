# frozen_string_literal: true

module TabcSi
  module PushManagers
    class ApnsManager < PushManager
      def initialize
        self.notification_builder = ApnsNotificationBuilder.new
        self.pusher = RubyPushNotifications::APNS::APNSPusher.new(
          File.read(Rails.root.join('apns.pem')),
          Rails.env.production? && Nenv.instance.app_debug?
        )
      end

      class ApnsNotificationBuilder
        def build(tokens, message)
          RubyPushNotifications::APNS::APNSNotification.new(
            tokens,
            aps: {
              alert: {
                title: 'TABC: CR News',
                body: message[:subject]
              },
              badge: 1,
              sound: 'default'
            },
            news: message
          )
        end
      end
    end
  end
end
