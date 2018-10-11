# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :require_logged_in_user
  skip_before_action :set_page_options

  layout false

  def docs
    @spec_url = "/api/#{params[:version]}/docs_spec"
  end
end
