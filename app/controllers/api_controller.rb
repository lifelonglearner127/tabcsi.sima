# frozen_string_literal: true

class ApiController < ApplicationController
  layout false

  def docs
    @spec_url = "/api/#{params[:version]}/docs_spec"
  end
end
