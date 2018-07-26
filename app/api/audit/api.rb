# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module Audit
  class Api < Grape::API
    helpers Doorkeeper::Grape::Helpers

    content_type :json, 'application/json'

    default_format :json

    before do
      if request.path.end_with? '/docs_spec'
        # restrict access to allowed IP addresses
      else
        doorkeeper_authorize!
      end
    end

    mount V1Api
  end
end
