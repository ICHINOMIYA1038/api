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
      tags = params[:tags]
      tagcondition = params[:tagcondition] || "all"



      if tags
        tag_names = params[:tags].split(',') # タグをカンマ区切りの文字列から配列に変換
        tag_names.each do |tag_name|
          tag = Tag.find_by(name: tag_name)
          tag_ids = Tag.where(name: tag_names).pluck(:id) # タグ名に対応するタグのIDを取得
          if tagcondition == 'all'
            @result = Post.left_joins(:posts_tags)
             .where(posts_tags: { tag_id: [1, 2] })
             .group("posts.post_id")
             .having("COUNT(posts.post_id) = 2")
             .select("posts.post_id")
            @data = Post.where(post_id: @result)
          elsif tagcondition == 'any'
            @data = @data.joins(:tags).where(tags: { id: tag_ids }).distinct
          elsif tagcondition == 'none'
            @data = @data.joins(:tags).where(tags: { id: tag_ids }).where(tags: { id: nil })
          end
        end
      elsif
        posts = Post.includes(:tags)
        @data = Post.joins(:user).joins(:tags)

      end
      
      @data=@data.where(
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

      if params[:sort_by] == '3'
        @data = @data.order(total_number_of_people: :asc)
      end

      if params[:sort_by] == '4'
        @data = @data.order(playtime: :asc)
      end

      if params[:sort_by].nil? || params[:sort_by] == '5'
        @data = @data.order(created_at: :desc)
      end

      @data = @data.includes(:tags).as_json(include: :tags, methods: [:file_url, :image_url, :user_image_url])

      # 必要な処理を記述して、条件に合ったデータを取得します
  
      render json: { data: @data} # 取得したデータをJSON形式で返す例
    end
  end