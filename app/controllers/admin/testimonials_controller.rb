class Admin::TestimonialsController < Admin::AdminController
  
  handles_images_for Testimonial
  
  def index
    if params[:search] && params[:search][:order]
      @search = Testimonial.unrecycled.search(params[:search])
    else
      @search = Testimonial.unrecycled.position.search(params[:search])
    end
    @testimonials = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def index_update
    params[:ids] ||= []
    @search = Testimonial.unrecycled.search(params[:search])
    @testimonials = @search.paginate(:page => params[:page], :per_page => 50) 
    for testimonial in @testimonials
      if params[:ids].include? testimonial.id.to_s
        testimonial.highlight = true
      else
        testimonial.highlight = false
      end
      testimonial.save
    end
    redirect_to :action => :index, :search => params[:search], :page => params[:page]
  end
  
  def new
    @testimonial = Testimonial.new
  end
  
  def create
    @testimonial = Testimonial.new(params[:testimonial])
    if @testimonial.save
      flash[:notice] = "Successfully created Testimonial."
      if Testimonial.image_changes?(params[:testimonial])
        redirect_to :action => "index_images", :id => @testimonial.id
      else
        redirect_to admin_testimonials_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @testimonial = Testimonial.find(params[:id])
  end
  
  def update
    @testimonial = Testimonial.find(params[:id])
    if @testimonial.update_attributes(params[:testimonial])
      flash[:notice] = "Successfully updated Testimonial."
      if Testimonial.image_changes?(params[:testimonial])
        redirect_to :action => "index_images", :id => @testimonial.id
      else
        redirect_to admin_testimonials_path
      end
    else
      render :action => 'edit'
    end
  end  
  
  def order
    params[:draggable].each_with_index do |id, index|
      Testimonial.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  
  
  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    flash[:notice] = "Successfully destroyed Testimonial."
    redirect_to admin_testimonials_path
  end
  
end
