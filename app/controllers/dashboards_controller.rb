# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show; end

  private

  def company
    relation = User.all
    options = nil

    if current_user.admin?
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
    options = {
      html: {
        user: current_user.info
      }
    }

    if current_user.tabc?
      options[:html][:tabc] = tabc_admin_info
    else
      options[:html][:company] = company
    end

    if current_user.admin?
      options[:html][:admin_count] = current_user.company.admin_count
    end

    options
  end

  def tabc_admin_info
    info = {}

    info[:locations] =
      Location
      .joins(:company)
      .includes(:company)
      .where(companies: { owned: true })
      .as_json(include: :company)

    info[:news] =
      News
      .includes(:user)
      .as_json(include: :user)

    info[:users] =
      User
      .with_discarded
      .includes(:company)
      .as_json(include: :company)

    info
  end
end
