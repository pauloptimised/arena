class ProductsController < ApplicationController
  
  def index
    if params[:category] && params[:make]
      @category = Category.find(params[:category])
      @make = Make.find(params[:make])
      @title = "#{@make.name} #{@category.name}"
      @search  = Product.active.find(:all, :conditions => "category_id = '#{@category.id}' AND make_id = '#{@make.id}'")
    elsif params[:category]
      @category = Category.find(params[:category])
      @title = "#{@category.name}"
      @search  = Product.active.find(:all, :conditions => "category_id = #{@category.id}")
    elsif params[:make]
      @make = Make.find(params[:make])
      @title = "#{@make.name}"
      @search  = Product.active.find(:all, :conditions => "make_id = #{@make.id}")
    else
      @title = "Products"
      @search  = Product.active
    end
    @products = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    redirect_to :index
  end
  
end
