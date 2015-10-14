class CategoriesController < ApplicationController
  
  def show
   @missions = Mission.where(category_id: params[:id])
  end
  
  def index
    @categories = Category.all
  end
end
