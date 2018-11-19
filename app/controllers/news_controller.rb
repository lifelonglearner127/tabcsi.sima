# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :require_logged_in_user, except: %i[show]
  before_action :set_news, only: %i[destroy edit show update]
  before_action :set_page_options, except: %i[create destroy update]

  TRACK_ATTRIBUTES = %i[subject content].freeze

  def create
    news = News.new(news_params)
    news.user_id = current_user.id

    if news.save
      action_log(
        'news_controller',
        "#{user_to_string} created a news item. #{news_to_string(news)}."
      )
      redirect_to dashboard_url
    else
      render 'new'
    end
  end

  def destroy
    @news.discard
    action_log(
      'news_controller',
      "#{user_to_string} deleted a news item."
    )
    head :no_content
  end

  def edit; end

  def new; end

  def show
    @hide_site_version = true
  end

  def update
    if @news.update!(news_params)
      changes_msg = []
      field_changes = @news.previous_changes

      unless field_changes.empty?
        TRACK_ATTRIBUTES.each do |attr|
          unless field_changes[attr].nil?
            changes_msg << "#{attr}: #{field_changes[attr][0]} => #{field_changes[attr][1]}"
          end
        end

        action_log(
          'news_controller',
          "#{user_to_string} updated a news item. #{changes_msg.join(', ')}."
        )
      end

      redirect_to dashboard_url
    else
      render 'edit'
    end
  end

  private

  def controller_page_options
    case action_name
    when 'new'
      {
        url: news_index_path,
        method: 'post',
        local: true,
        html: {
          news_types: news_types
        }
      }
    when 'edit'
      {
        url: news_path,
        method: 'PUT',
        local: true,
        html: {
          news: @news,
          news_types: news_types
        }
      }
    else
      {
        html: {
          news: @news,
          hide_cookie_consent: true
        }
      }
    end
  end

  def news_params
    params
      .require(:news)
      .permit(
        :news_type, :subject, :content
      )
  end

  def news_types
    types = News.news_types
    formatted_types = []

    types.keys.each do |key|
      formatted_types << { value: key, text: key.titleize }
    end

    formatted_types
  end

  def set_news
    @news = News.find(params.require(:id))
  end

  def user_to_string
    "#{current_user.full_name} (#{current_user.id})"
  end

  def news_to_string(news)
    "subject: #{news.subject}, body: #{news.content}"
  end
end
