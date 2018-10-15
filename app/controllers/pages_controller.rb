# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :require_logged_in_user
  skip_before_action :set_page_options

  include HighVoltage::StaticPage

  def show
    @hide_site_version = true

    super
  end
end
