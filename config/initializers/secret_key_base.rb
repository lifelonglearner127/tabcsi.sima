# frozen_string_literal: true

if Rails.env.production?
  server_key = Nenv.instance.app_debug? ? :sandbox : :production

  Rails.application.config.secret_key_base =
    Rails.application.credentials.dig(server_key, :secret_key_base)
end
