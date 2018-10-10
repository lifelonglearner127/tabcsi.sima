# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show; end

  private

  def company
    relation = User.all
    options = nil

    if current_user.admin? || current_user.tabc?
      relation = relation.includes(
        company: {
          locations: :licenses,
          users: :licenses
        }
      )

      options = {
        include: {
          locations: { include: :licenses },
          users: { include: :licenses }
        }
      }
    end

    relation
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
