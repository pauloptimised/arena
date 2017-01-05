class Admin::GalleriesController < Admin::AdminController
  
  def index
    @search = Gallery.unrecycled.position.search(params[:search])
    @galleries = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:notice] = "Successfully created Arena Community Gallery."
      redirect_to admin_galleries_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
  end
  
  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      flash[:notice] = "Successfully updated Arena Community Gallery."
      redirect_to admin_galleries_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Gallery.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    flash[:notice] = "Successfully destroyed Arena Community Gallery."
    redirect_to admin_galleries_path
  end
  
end
