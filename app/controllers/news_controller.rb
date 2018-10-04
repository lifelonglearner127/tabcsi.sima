# frozen_string_literal: true

class NewsController < ApplicationController
  skip_before_action :set_page_options, only: %i[create update]
  before_action :set_news, only: %i[edit show update destroy]

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

  def build_page_options(page_name)
    reset_page_options(provided_page_options(page_name))
  end

  def controller_page_options(page_name = action_name)
    page_options =
      case page_name
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
            news_types: news_types
          }
        }
      else
        {}
      end

    page_options
  end
end
