class TagsController < ApplicationController
    def create
      tag = Tag.new(tag_params)
      if tag.save
        render json: { tag: tag }, status: :created
      else
        render json: { error: tag.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def index
      tags = Tag.all
      render json: { tags: tags }, status: :ok
    end
  
    private
  
    def tag_params
      params.require(:tag).permit(:name)
    end
  end
