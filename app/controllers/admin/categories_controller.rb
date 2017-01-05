class Admin::CategoriesController < Admin::AdminController
  
  handles_images_for Category
  
  def index
    @search = Category.unrecycled.search(params[:search])
    @categories = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Successfully created Category."
      if Category.image_changes?(params[:category])
        redirect_to :action => "index_images", :id => @category.id
      else
        redirect_to admin_categories_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated Category."
      if Category.image_changes?(params[:category])
        redirect_to :action => "index_images", :id => @category.id
      else
        redirect_to admin_categories_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Category.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully destroyed Category."
    redirect_to admin_categories_path
  end
  
end
