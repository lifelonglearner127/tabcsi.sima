# frozen_string_literal: true

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
    require 'fileutils'

    target = File.join(
      'tmp', 'uploads', "#{Time.now.to_i}_#{file.original_filename}"
    )
    FileUtils.cp file.path, target

    target
  end

  def import_params
    params.require(:import).permit(:file)
  end

  def build_page_options(page_name)
    reset_page_options(controller_page_options(page_name))
  end

  def controller_page_options(page_name = action_name)
    case page_name
    when 'upload_csv'
      {
        url: import_users_path,
        method: 'post',
        local: true,
        html: {}
      }
    else
      {}
    end
  end
end
