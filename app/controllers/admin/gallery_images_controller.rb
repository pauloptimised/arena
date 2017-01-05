class Admin::GalleryImagesController < Admin::AdminController

  handles_images_for GalleryImage

  def index
    if !params[:gallery_id].blank?
      session[:gallery_id] = params[:gallery_id]
		end
    @gallery = Gallery.find(session[:gallery_id])
    @search = GalleryImage.unrecycled.position.gallery_id(@gallery.id).search(params[:search])
    @gallery_images = @search.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @gallery = Gallery.find(session[:gallery_id])
    @gallery_image = GalleryImage.new(:gallery_id => @gallery.id)
  end

  def create
    @gallery_image = GalleryImage.new(params[:gallery_image])
    if @gallery_image.save
      flash[:notice] = "Successfully created Gallery Image."
      redirect_to admin_gallery_images_path(:gallery_id => @gallery_image.gallery.id)
    else
      render :action => 'new'
    end
  end

  def edit
    @gallery_image = GalleryImage.find(params[:id])
  end

  def update
    @gallery_image = GalleryImage.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])
    if @gallery_image.update_attributes(params[:gallery_image])
      flash[:notice] = "Successfully updated Gallery Image."
      redirect_to admin_gallery_images_path(:gallery_image => @gallery_image.id)
    else
      render :action => 'edit'
    end
  end

  def order
    params[:draggable].each_with_index do |id, index|
      GalleryImage.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  def destroy
    @gallery_image = GalleryImage.find(params[:id])
    @gallery_image.destroy
    flash[:notice] = "Successfully destroyed Gallery Image."
    redirect_to admin_gallery_images_path
  end

end
