class CategoriesController < ApplicationController
  
  def index
    @title = "Products"
    @search = Category.active.position
    @categories = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    redirect_to :index
  end
  
end
