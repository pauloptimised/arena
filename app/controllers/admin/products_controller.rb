class Admin::ProductsController < Admin::AdminController
  
  handles_images_for Product
  handles_documents_for Product
  
  def index
    @search = Product.unrecycled.search(params[:search])
    @products = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def index_update
    params[:ids] ||= []
    @search = Product.unrecycled.search(params[:search])
    @products = @search.paginate(:page => params[:page], :per_page => 50)
    for product in @products
      if params[:ids].include? product.id.to_s
        product.highlight = true
      else
        product.highlight = false
      end
      product.save
    end
    redirect_to :action => :index, :search => params[:search], :page => params[:page]
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Successfully created Product."
      if Product.image_changes?(params[:product])
        redirect_to :action => "index_images", :id => @product.id
      else
        redirect_to admin_products_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated Product."
      if Product.image_changes?(params[:product])
        redirect_to :action => "index_images", :id => @product.id
      else
        redirect_to admin_products_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Product.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Successfully destroyed Product."
    redirect_to admin_products_path
  end
  
end
