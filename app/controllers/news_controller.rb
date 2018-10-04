# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_page_options
  before_action :set_news, only: %i[edit show update]

  def index; end

  def new; end

  def create
    news = News.new(news_params)
    news.user_id = current_user.id

    if news.save
      redirect_to dashboard_url
    else
      render 'new'
    end
  end

  def edit
    page_data_options[:html][:news] = @news
  end

  def update
    if @news.update!(news_params)
      redirect_to dashboard_url
    else
      render 'edit'
    end
  end

  def show
    page_data_options[:html] = { news: @news }
  end

  private

  def set_news
    @news = News.find(params[:id])
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
    formated_types = []

    types.keys.each do |key|
      formated_types << { value: key, text: key.titleize }
    end

    formated_types
  end

  def set_page_options
    self.page_data_options =
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
        self.page_data_options = {
          url: news_path,
          method: 'PUT',
          local: true,
          html: {
            news_types: news_types
          }
        }
      else
        self.page_data_options = {}
      end
  end
end
