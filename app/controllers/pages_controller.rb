# frozen_string_literal: true

class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def show
    @hide_site_version = true

    super
  end
end
