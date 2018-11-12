# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action -> { require_logged_in_user(:tabc) }

  def create
    Report.create!(
      user_id: current_user.id,
      **report_params
    )

    head :no_content
  end

  private

  def report_params
    params =
      self
      .params
      .require(:report)
      .permit(:include_received, :fiscal_year)
      .to_h
      .deep_symbolize_keys

    params[:include_received] =
      ['true', true].include?(params[:include_received])

    params
  end
end
