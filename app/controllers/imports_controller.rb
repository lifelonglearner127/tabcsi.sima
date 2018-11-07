# frozen_string_literal: true

require 'fileutils'

class ImportsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_page_options, only: %i[upload_users_csv]

  def upload_users_csv; end

  def users
    upload_file = import_params[:file]
    csv_file = move_file(upload_file)

    CsvJob.perform_later(csv_file, current_user)

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
    target = "tmp/uploads/#{Time.now.to_i}_#{file.original_filename}"

    FileUtils.cp(file.path, target)

    target
  end
end
