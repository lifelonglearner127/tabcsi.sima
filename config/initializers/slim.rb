# frozen_string_literal: true

Slim::Engine.set_options(
  format: :html,
  pretty: Rails.env.development?
)
