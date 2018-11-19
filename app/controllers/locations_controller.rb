# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_location

  def reset
    @location.reset(location: true, lock: true, destroy_inspections: true)

    action_log(
      'locations_controller',
      "#{user} reset location id #{@location.id} on #{current_time}."
    )

    head :no_content
  end

  private

  def current_time
    Time.current.strftime('%-m/%-d/%Y at %-l:%M %p %Z')
  end

  def set_location
    @location = Location.find(params.require(:id))
  end

  def user
    "#{current_user.full_name} (#{current_user.id})"
  end
end
