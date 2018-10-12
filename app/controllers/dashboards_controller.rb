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
      .includes(:company, :inspected_by, :licenses, :locked_by)
      .where(companies: { owned: true })
      .order(:name, :clp)
      .as_json(include: %i[company inspected_by licenses locked_by])

    info[:news] =
      News
      .includes(:user)
      .order(created_at: :desc)
      .as_json(include: :user)

    info[:users] =
      User
      .with_discarded
      .includes(:company, :licenses, :users_licenses)
      .order(:full_name)
      .as_json(include: %i[company licenses])

    info
  end
end
