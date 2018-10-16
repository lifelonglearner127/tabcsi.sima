# frozen_string_literal: true

class LocationsController < ApplicationController
  skip_before_action :set_page_options
  before_action :set_location

  def reset
    @location.reset(location: true, lock: true, destroy_inspections: true)

    action_log("#{user} reset location id #{@location.id} on #{current_time}.")

    redirect_to dashboard_url
  end

  private

  def action_log(message)
    ActionLog.create!(
      sequence_id: sequence_id,
      tag: 'locations_controller',
      message: message
    )
  end

  def current_time
    Time.zone.now.strftime('%-m/%-d/%Y at %-l:%M %p %Z')
  end

  def sequence_id
    @sequence_id ||= ActionLog.sequence_id
  end

  def set_location
    @location = Location.find(params.require(:id))
  end

  def user
    "#{current_user.full_name} <#{current_user.email}>"
  end
end
