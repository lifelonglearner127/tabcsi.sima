# frozen_string_literal: true

require 'fileutils'

class ImportsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_page_options, only: %i[upload_users_csv]

  def upload_users_csv; end

  def users
    uploaded_file = import_params[:file]
    csv_path = move_file(uploaded_file)

    ImportsJob.set(wait: 5.seconds).perform_later(current_user, csv_path)
    action_log(
      'imports_controller',
      "#{user} has queued users import #{File.basename(csv_path)}."
    )

    redirect_to dashboard_url
  end

  private

  def controller_page_options
    {
      url: users_import_path,
      method: 'post',
      local: true
    }
  end

  def import_params
    params.require(:import).permit(:file)
  end

  def move_file(file)
    target =
      Rails.root.join("tmp/uploads/#{Time.now.to_i}_#{file.original_filename}")
    dir = File.dirname(target)

    FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
    FileUtils.cp(file.path, target)

    target.to_s
  end

  def user
    "#{current_user.full_name} (#{current_user.id})"
  end
end
