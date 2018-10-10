# frozen_string_literal: true

module TabcSi
  module V1
    class NewsApi < Grape::API
      resources :news do
        desc(
          'Get News',
          detail: 'Retrieves all news items.',
          is_array: true,
          success: {
            model: Entities::NewsEntity,
            message: 'A collection of news items.'
          }
        )
        get do
          respond News.all
        end
      end
    end
  end
end
