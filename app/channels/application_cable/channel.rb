# frozen_string_literal: true

module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def self.broadcast_to(model, message)
      super(model, TabcSi.transform_response_json(message))
    end
  end
end
