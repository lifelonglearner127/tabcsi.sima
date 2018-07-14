# frozen_string_literal: true

module Api
  module V1
    class BaseV1Controller < BaseApiController
      before_action :authenticate_api_v1_user!
    end
  end
end
