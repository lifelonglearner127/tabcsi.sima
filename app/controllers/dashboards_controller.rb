# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_page_options

  def show; end

  private

  def company
    relation = User.all
    options = nil

    if current_user.admin?
      relation = relation.includes(
        company: {
          locations: :licenses,
          users: {
            licenses: :location
          }
        }
      )

      options = {
        include: {
          locations: { include: :licenses },
          users: {
            include: {
              licenses: { include: :location }
            }
          }
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
        tabc_contact_url: Setting.tabc_contact_url,
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

    info[:users] =
      User
      .with_discarded
      .left_outer_joins(:company)
      .includes(:company, licenses: :location)
      .where(orphaned: false)
      .order(Company.arel_table[:name].asc, :full_name)
      .as_json(
        include: {
          company: {},
          licenses: { include: :location }
        }
      )

    info[:locations] =
      Location
      .joins(:company)
      .includes(:company, :inspected_by, :licenses, :locked_by)
      .where(companies: { owned: true })
      .order(Company.arel_table[:name].asc, :name, :clp)
      .as_json(include: %i[company inspected_by licenses locked_by])

    info[:news] =
      News
      .includes(:user)
      .order(created_at: :desc)
      .as_json(include: :user)

    now = nil
    start_of_fiscal_year = nil
    Time.use_zone('Central Time (US & Canada)') do
      now = Time.current
      start_of_fiscal_year = Time.zone.local(now.year, 9, 1)
    end

    current_fiscal_year = now.year + (now < start_of_fiscal_year ? 0 : 1)
    info[:fiscal_years] =
      (
        Inspection
        .select(:fiscal_year)
        .distinct
        .pluck(:fiscal_year)
        .map(&:to_i) +
        (Setting::DEFAULTS[:fiscal_year]..current_fiscal_year).to_a
      )
      .uniq
      .sort
      .map do |year|
        {
          text: year.to_s,
          value: year
        }
      end

    info[:reports] =
      Report
      .includes({ file_attachment: :blob }, :user)
      .order(updated_at: :desc)
      .map(&:to_hash)
      .as_json

    info
  end
end
