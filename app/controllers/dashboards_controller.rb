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

    User
      .includes(
        company: {
          locations: :licenses
        }
      )
      .find(current_user.id)
      .company
      .as_json(options)
  end

  def set_page_options
    self.page_data_options = {
      html: {
        admin_count: current_user.company.admin_count,
        company: company,
        user: current_user.info
      }
    }
  end
end
