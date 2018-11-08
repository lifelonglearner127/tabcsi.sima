# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :cable_user

    def connect
      self.cable_user = find_verified_user

      logger.add_tags 'ActionCable', cable_user.id
    end

    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def find_verified_user
      current_user.presence || reject_unauthorized_connection
    end

    def session
      request.session
    end
  end
end
