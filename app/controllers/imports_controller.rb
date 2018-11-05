# frozen_string_literal: true

require 'fileutils'

class ImportController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_page_options, only: %i[upload_csv]

  def upload_csv; end

  def users
    upload_file = import_params[:file]
    csv_file = move_file(upload_file)

    CsvJob.perform_later(csv_file, current_user)

    redirect_to dashboard_url
  end

  private

  def move_file(file)
    target = "tmp/uploads/#{Time.now.to_i}_#{file.original_filename}"

    FileUtils.cp(file.path, target)

    target
  end

  def import_params
    params.require(:import).permit(:file)
  end

  def controller_page_options
    {
      url: import_users_path,
      method: 'post',
      local: true
    }
  end
end
