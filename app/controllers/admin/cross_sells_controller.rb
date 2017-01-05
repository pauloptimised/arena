class Admin::CrossSellsController < Admin::AdminController
  
  handles_images_for CrossSell
  
  def index
    @search = CrossSell.unrecycled.search(params[:search])
    @cross_sells = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @cross_sell = CrossSell.new
  end
  
  def create
    @cross_sell = CrossSell.new(params[:cross_sell])
    if @cross_sell.save
      flash[:notice] = "Successfully created Cross Sell."
      if CrossSell.image_changes?(params[:cross_sell])
        redirect_to :action => "index_images", :id => @cross_sell.id
      else
        redirect_to admin_cross_sells_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cross_sell = CrossSell.find(params[:id])
  end
  
  def update
    @cross_sell = CrossSell.find(params[:id])
    if @cross_sell.update_attributes(params[:cross_sell])
      flash[:notice] = "Successfully updated Cross Sell."
      if CrossSell.image_changes?(params[:cross_sell])
        redirect_to :action => "index_images", :id => @cross_sell.id
      else
        redirect_to admin_cross_sells_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      CrossSell.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @cross_sell = CrossSell.find(params[:id])
    @cross_sell.destroy
    flash[:notice] = "Successfully destroyed Cross Sell."
    redirect_to admin_cross_sells_path
  end
  
end
