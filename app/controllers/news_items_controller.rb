class NewsItemsController < ApplicationController
    def index
        @news = NewsItem.order(created_at: :desc).limit(10)
        render json: @news
    end 
end