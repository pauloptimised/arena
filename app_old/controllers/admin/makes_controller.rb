class Admin::MakesController < Admin::AdminController
  
  handles_images_for Make
  
  def index
    @search = Make.unrecycled.search(params[:search])
    @makes = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @make = Make.new
  end
  
  def create
    @make = Make.new(params[:make])
    if @make.save
      flash[:notice] = "Successfully created Make."
      if Make.image_changes?(params[:make])
        redirect_to :action => "index_images", :id => @make.id
      else
        redirect_to admin_makes_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @make = Make.find(params[:id])
  end
  
  def update
    @make = Make.find(params[:id])
    if @make.update_attributes(params[:make])
      flash[:notice] = "Successfully updated Make."
      if Make.image_changes?(params[:make])
        redirect_to :action => "index_images", :id => @make.id
      else
        redirect_to admin_makes_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Make.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @make = Make.find(params[:id])
    @make.destroy
    flash[:notice] = "Successfully destroyed Make."
    redirect_to admin_makes_path
  end
  
end
