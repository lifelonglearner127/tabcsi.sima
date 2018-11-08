# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :cable_user

    def connect
      self.cable_user = find_verified_user

      logger.add_tags 'ActionCable', cable_user.id
    end

    private

    def find_verified_user
      User.find_by(id: request.session[:user_id]).presence ||
        reject_unauthorized_connection
    end
  end
end
