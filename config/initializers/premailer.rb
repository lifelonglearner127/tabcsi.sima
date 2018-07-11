# frozen_string_literal: true

Premailer::Rails.config.merge!(
  remove_ids: true,
  remove_classes: true,
  remove_comments: true,
  adapter: :nokogiri
)
