# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_logged_in_user, only: %i[destroy edit invite update]
  before_action :set_user, only: %i[destroy edit show update]
  before_action :set_page_options, only: %i[edit invite new]

  TRACK_ATTRIBUTES = %i[full_name email phone job_title role].freeze

  def create
    @user = User.create(normalized_user_params)

    if @user.persisted?
      if @user.invited?
        admin = User.find(@user.by_whom_id)
        log_msg =
          "#{user_to_string(admin)} invited #{user_to_string(@user)} to #{company_to_string(admin.company)}."
      else
        log_msg =
          "#{user_to_string(@user)} registered for #{@user.company.name}."
      end

      action_log(
        'users_controller',
        log_msg
      )

      redirect_to(
        @user.invited? ? dashboard_url : log_in_url,
        notice: successful_create_notice(@user)
      )

      return
    end

    page_name, action = @user.invited? ? %w[invite invite] : [nil, 'new']

    build_page_options(page_name)

    render action
  end

  def destroy
    @user.discard
    action_log(
      'users_controller',
      "#{user_to_string(current_user)} deleted #{user_to_string(@user)}."
    )

    # reset company; method checks user count first
    @user.company.reset
    action_log(
      'users_controller',
      "#{company_to_string(@user.company)} was reset."
    )

    head :no_content
  end

  def edit
    # security:
    # * don't allow regular users to edit other users
    # * don't allow admins to edit non-company users
    if (current_user.user? && !profile?) ||
       (current_user.admin? && @user.company_id != current_user.company_id)
      redirect_to(dashboard_url)
    end
  end

  def invite
    redirect_to(dashboard_url) if current_user.user? || current_user.tabc?
  end

  def new
    redirect_to(dashboard_url) if logged_in?
  end

  def undiscard
    user = User.with_discarded.find(params[:id])
    user.undiscard
    action_log(
      'users_controller',
      "#{user_to_string(current_user)} undeleted #{user_to_string(@user)}."
    )

    head :no_content
  end

  def update
    if @user.update(normalized_user_params)
      changes_msg = []
      field_changes = @user.previous_changes

      unless field_changes.empty?
        TRACK_ATTRIBUTES.each do |attr|
          unless field_changes[attr].nil?
            changes_msg << "#{attr}: #{field_changes[attr][0]} => #{field_changes[attr][1]}"
          end
        end

        if profile?
          action_log(
            'users_controller',
            "#{user_to_string(@user)} updated their profile. #{changes_msg.join(', ')}."
          )
        else
          action_log(
            'users_controller',
            "#{user_to_string(current_user)} updated #{user_to_string(@user)} profile. #{changes_msg.join(', ')}."
          )
        end
      end

      redirect_to dashboard_url

      return
    end

    build_page_options('edit')

    render 'edit'
  end

  private

  def build_page_options(page_name)
    reset_page_options(controller_page_options(page_name))
  end

  def controller_page_options(page_name = action_name)
    page_options =
      case page_name
      when 'edit'
        {
          url: edit_user_path,
          method: 'patch',
          local: true,
          html: {
            is_profile: profile?,
            by_whom: current_user,
            locations: @user.tabc? ? [] : @user.company.locations,
            locked_locations: @user.locked_locations,
            logged_in_user_is_tabc: current_user.tabc?,
            page_name: 'edit'
          }
        }
      when 'invite'
        if current_user.tabc?
          { html: {} }
        else
          {
            url: invite_users_path,
            method: 'post',
            local: true,
            html: {
              by_whom: current_user,
              locations: current_user.company.locations,
              owner_name: current_user.company.owner_name,
              page_name: 'invite'
            }
          }
        end
      else
        {
          url: sign_up_path,
          method: 'post',
          local: true,
          html: { page_name: 'sign-up' }
        }
      end

    page_options[:html][:user] = @user&.info

    unless @user&.errors.blank?
      page_options[:html][:errors] = {
        base: @user.errors.full_messages.join(', ')
      }
    end

    page_options
  end

  def normalized_user_params
    params = user_params

    params[:full_name]&.strip!
    params[:email]&.strip!
    params[:phone]&.strip!
    params[:company_name]&.strip!
    params[:job_title]&.strip!
    params[:license_number]&.strip!

    params
  end

  def profile?
    @user.id == current_user.id
  end

  def set_user
    @user = User.find(params.require(:id))
  end

  def successful_create_notice(user)
    if user.invited?
      t('notices.users.create.invite')
    else
      t('notices.users.create.new')
    end
  end

  def user_params
    params
      .require(:user)
      .permit(
        :company_name, :email, :full_name, :invited, :job_title,
        :license_number, { location_clps: [] }, :owner_name, :phone, :profile,
        :role,
        :by_whom_id
      )
  end

  def user_to_string(user)
    "#{user.full_name} (#{user.id})"
  end

  def company_to_string(company)
    "#{company.name} (#{company.id})"
  end
end
