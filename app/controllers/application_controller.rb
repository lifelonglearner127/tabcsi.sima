# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :set_paper_trail_whodunnit

  attr_writer :page_data_options

  def page_data_options
    @page_data_options || {}
  end

  helper_method :page_data_options
end
