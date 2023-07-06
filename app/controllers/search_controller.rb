# app/controllers/search_controller.rb
class SearchController < ApplicationController
    def index
      keyword = params[:keyword]
      start_date = params[:startDate] 
      end_date = params[:endDate] 
      min_male_count = params[:minMaleCount]
      max_male_count = params[:maxMaleCount] 
      min_female_count = params[:minFemaleCount]
      max_female_count = params[:maxFemaleCount] 
      min_total_count = params[:minTotalCount]
      max_total_count = params[:maxTotalCount]
      min_playtime = params[:minPlaytime]
      max_playtime = params[:maxPlaytime]
      
      puts min_female_count

      @data = Post.joins(:user).where(
        "title LIKE :keyword OR catchphrase LIKE :keyword OR users.name LIKE :keyword",
        keyword: "%#{keyword}%"
      )
      .where("createdAt >= ?", start_date.presence || Post.minimum(:createdAt))
      .where("createdAt <= ?", end_date.presence|| Post.maximum(:createdAt))
      .where(number_of_men: (min_male_count.presence || "0")..(max_male_count.presence ||  "100"))
      .where(number_of_women: (min_female_count.presence || "0")..(max_female_count.presence ||  "100"))
      .where(total_number_of_people: (min_total_count.presence || "0")..(max_total_count.presence || "100"))
      .where(playtime: (min_playtime.presence || "0")..(max_playtime.presence || "100"))
      .all

      if params[:sort_by] == 'number_of_people'
        @data = @data.order(total_number_of_people: :asc)
      end

      if params[:sort_by] == 'playtime'
        @data = @data.order(playtime: :asc)
      end

      if params[:sort_by].nil? || params[:sort_by] == 'created_at'
        @data = @data.order(created_at: :desc)
      end

      # 必要な処理を記述して、条件に合ったデータを取得します
  
      render json: { data: @data } # 取得したデータをJSON形式で返す例
    end
  end