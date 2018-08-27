# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_page_options

  def show; end

  private

  def company
    options = nil

    if current_user.admin?
      options = {
        include: {
          locations: { include: :licenses },
          users: {
            locations: { include: :licenses }
          }
        }
      }
    end

    current_user.company.as_json(options)
  end

  def set_page_options
    self.page_data_options = {
      html: {
        log_out: {
          path: log_out_path,
          method: :delete
        },
        user: current_user.info,
        company: company
      }
    }
  end
end
