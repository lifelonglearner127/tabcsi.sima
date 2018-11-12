# frozen_string_literal: true

if Rails.env.production?
  server_key = Nenv.instance.app_debug? ? :sandbox : :production

  access_key_id =
    Rails.application.credentials.dig(server_key, :aws, :access_key_id)

  secret_access_key =
    Rails.application.credentials.dig(server_key, :aws, :secret_access_key)

  Aws::Rails.add_action_mailer_delivery_method(
    :aws_sdk,
    credentials: Aws::Credentials.new(access_key_id, secret_access_key),
    region: Nenv.instance.aws_region
  )

  s3_access_key_id =
    Rails.application.credentials.dig(server_key, :s3, :access_key_id) ||
    access_key_id

  s3_secret_access_key =
    Rails.application.credentials.dig(server_key, :s3, :secret_access_key) ||
    secret_access_key

  Rails.configuration.aws = {
    s3: {
      access_key_id: s3_access_key_id,
      secret_access_key: s3_secret_access_key
    }
  }
else
  Rails.configuration.aws = {}
end
