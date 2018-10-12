# frozen_string_literal: true

module TabcSi
  module PushManagers
    class FcmManager < PushManager
      def initialize
        self.notification_builder = FcmNotificationBuilder.new
        self.pusher = RubyPushNotifications::FCM::FCMPusher.new(fcm_key)
      end

      private

      def fcm_key
        if Rails.env.production?
          server_key = Nenv.instance.app_debug? ? :sandbox : :production

          return Rails.application.credentials.dig(server_key, :fcm_key)
        end

        Nenv.instance.fcm_key
      end

      class FcmNotificationBuilder
        def build(tokens, message)
          RubyPushNotifications::FCM::FCMNotification.new(
            tokens,
            message
          )
        end
      end
    end
  end
end
