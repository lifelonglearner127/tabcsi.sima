# frozen_string_literal: true

module TabcSi
  class PushManager
    def self.send(android_tokens, ios_tokens, message)
      PushManagers::FcmManager.new.send(android_tokens, message)
      PushManagers::ApnsManager.new.send(ios_tokens, message)
    end

    def send(tokens, message)
      notification = build_notification(tokens, message)

      pusher.push([notification])

      # push was successful as long as at least one token was successful
      notification.success.positive?
    end

    protected

    attr_accessor :pusher
    attr_accessor :notification_builder

    private

    def build_notification(tokens, message)
      notification_builder.build(tokens, message)
    end
  end
end
