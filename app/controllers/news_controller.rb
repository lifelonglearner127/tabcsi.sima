# frozen_string_literal: true

class NewsController < ApplicationController
  skip_before_action :require_logged_in_user, only: %i[show]
  prepend_before_action :set_news, only: %i[destroy edit show update]
  skip_before_action :set_page_options, only: %i[create destroy update]

  def create
    news = News.new(news_params)
    news.user_id = current_user.id

    if news.save
      redirect_to dashboard_url
    else
      render 'new'
    end
  end

  def destroy
    @news.discard

    head :no_content
  end

  def edit; end

  def new; end

  def show; end

  def update
    if @news.update!(news_params)
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
      { html: { news: @news } }
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
    @news = News.find(params[:id])
  end
end
