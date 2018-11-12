# frozen_string_literal: true

class ReportsChannel < ApplicationCable::Channel
  def subscribed
    stream_for cable_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
