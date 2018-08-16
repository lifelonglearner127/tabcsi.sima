# frozen_string_literal: true

module Grape
  class Request < Rack::Request
    ENV_METHODS ||= %w[
      AUTH_TYPE GATEWAY_INTERFACE PATH_TRANSLATED REMOTE_HOST REMOTE_IDENT
      REMOTE_USER REMOTE_ADDR SERVER_NAME SERVER_PROTOCOL ORIGINAL_SCRIPT_NAME
      HTTP_ACCEPT HTTP_ACCEPT_CHARSET HTTP_ACCEPT_ENCODING HTTP_ACCEPT_LANGUAGE
      HTTP_CACHE_CONTROL HTTP_FROM HTTP_NEGOTIATE HTTP_PRAGMA HTTP_CLIENT_IP
      HTTP_X_FORWARDED_FOR HTTP_ORIGIN HTTP_VERSION HTTP_X_CSRF_TOKEN
      HTTP_X_REQUEST_ID HTTP_X_FORWARDED_HOST SERVER_ADDR
    ].freeze

    ENV_METHODS.each do |env|
      env_name = env.sub(/^HTTP_/n, '').downcase

      class_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{env_name}               # def accept_charset
          get_header('#{env}'.freeze) #   get_header('HTTP_ACCEPT_CHARSET'.freeze)
        end                           # end
      METHOD
    end
  end
end
