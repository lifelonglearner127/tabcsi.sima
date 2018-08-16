# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy. For further information
# see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https, :blob
  policy.font_src :self, :https, :data
  policy.img_src :self, :https, :data
  policy.object_src :none
  policy.script_src :self, :https, :blob, :unsafe_eval, :unsafe_inline
  policy.style_src :self, :https, :unsafe_inline

  if Rails.env.development?
    policy.connect_src(
      :self, :https, 'https://localhost:3035', 'wss://localhost:3035'
    )
  end

  # Specify URI for violation reports.
  # policy.report_uri '/csp-violation-report-endpoint'
end

# If you are using UJS then enable automatic nonce generation.
# Rails.application.config.content_security_policy_nonce_generator =
#   ->(_request) { SecureRandom.base64(16) }

# Report CSP violations to a specified URI. For further information see the
# following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
