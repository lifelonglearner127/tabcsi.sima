# frozen_string_literal: true

class ApiController < ApplicationController
  layout false

  def docs
    @spec_url = "/api/#{params[:version]}/docs_spec"
  end

  # def spec
  #   binding.pry
  #
  #   json_schema = OpenApi.build_schema
  #
  #   render json: json_schema
  # end
end
