class Admin::ImagesController < Admin::AdminController

  require 'RMagick'

  def index
    @search = Image.newest.search(params[:search])
    @images = @search.paginate(:page => params[:page])
  end
  
  def new
    @image = Image.new
  end  

  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "Successfully created image."
      redirect_to admin_images_path
    else
      render :action => 'new'
    end
  end  
  
  def pre_alter
    params[:width] ||= 200
    params[:height] ||= 200
    @image = Image.find(params[:id])
  end
  
  def alter
    @image = Image.find(params[:id])
    unless params[:width].to_i > 0 || params[:height].to_i > 0
      flash[:error] = "Invalid dimensions"
      render :action => "pre_alter"
      return
    end
  end
  
  def execute_alter
    @image = Image.find(params[:id])
    image = @image.image
    scalar = Image.scalar(image)
    new = !params[:new].blank?
    if @image.crop(
      params[:x1].to_f/scalar,
      params[:y1].to_f/scalar,
      params[:width].to_f/scalar,
      params[:height].to_f/scalar,
      new,
      params[:ultimate_width],
      params[:ultimate_height]
      )
      if new
        flash[:notice] = "New stored image created"
      else
        flash[:notice] = "Stored image altered"
      end
    else
      flash[:error] = "There was a problem framing the image"
    end
    redirect_to admin_images_path
  end
  
  def alter_file
    @image = Magick::Image::read(params[:path]).first
    unless params[:width].to_i > 0 && params[:height].to_i > 0
      flash[:error] = "Invalid dimensions"
      redirect_to :back
      return
    end
  end
  
  def execute_alter_file
    @image = Magick::Image::read(params[:path]).first
    image = @image
    scalar = Image.scalar(image)
    new = !params[:new].blank?
    if Image.crop_file(
      @image,
      params[:path],
      params[:x1].to_f/scalar,
      params[:y1].to_f/scalar,
      params[:width].to_f/scalar,
      params[:height].to_f/scalar,
      params[:ultimate_width],
      params[:ultimate_height]
      )
      flash[:notice] = "Image altered"
    else
      flash[:error] = "There was a problem altering the image"
    end
    if params[:redirect_url]
      redirect_to params[:redirect_url]
    else
      redirect_to admin_path
    end
  end

  def edit
    @image = Image.find(params[:id])
  end  

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = "Successfully updated image."
      redirect_to admin_images_path
    else
      render :action => 'edit'
    end
  end  

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = "Successfully destroyed image."
    redirect_to admin_images_path
  end
  
  def execute_frame
    @image = Image.find(params[:id])
    image = @image.image
    scalar = Image.scalar(image)
    new = !params[:new].blank?
    if @image.crop(
      params[:x1].to_f/scalar,
      params[:y1].to_f/scalar,
      params[:width].to_f/scalar,
      params[:height].to_f/scalar,
      new
      )
      if new
        flash[:notice] = "New stored image created"
      else
        flash[:notice] = "Stored image altered"
      end
    else
      flash[:error] = "There was a problem framing the image"
    end
    redirect_to admin_images_path
  end
  
  def update_stored_images
    render :partial => "admin/form/stored_images", :locals => {:object => params[:object], :image => params[:image]}
  end

  def add_whitespace
    @image = Image.find(params[:id])
    @image.add_whitespace
    redirect_to :back
  end
  
  # Couldn't figure out how to pass params to redirect_to :back.
  # The existence of this method is ridiculous.
  def add_whitespace_from_alter
    @image = Image.find(params[:id])
    @image.add_whitespace
    redirect_to params.merge(:action => :alter, :id => @image.id)
  end
  
end
