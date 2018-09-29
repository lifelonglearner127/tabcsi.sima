# frozen_string_literal: true

class DashboardsController < ApplicationController
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

  def controller_page_options
    {
      html: {
        admin_count: current_user.company.admin_count,
        company: company,
        user: current_user.info
      }
    }
  end
end
