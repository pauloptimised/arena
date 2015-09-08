class Admin::StaffTestimonialsController < Admin::AdminController
  
  handles_images_for StaffTestimonial
  
  def index
    @search = StaffTestimonial.unrecycled.position.search(params[:search])
    @staff_testimonials = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @staff_testimonial = StaffTestimonial.new
  end
  
  def create
    @staff_testimonial = StaffTestimonial.new(params[:staff_testimonial])
    if @staff_testimonial.save
      flash[:notice] = "Successfully created Staff Testimonial."
      redirect_to admin_staff_testimonials_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @staff_testimonial = StaffTestimonial.find(params[:id])
  end
  
  def update
    @staff_testimonial = StaffTestimonial.find(params[:id])
    if @staff_testimonial.update_attributes(params[:staff_testimonial])
      flash[:notice] = "Successfully updated Staff Testimonial."
      redirect_to admin_staff_testimonials_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      StaffTestimonial.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @staff_testimonial = StaffTestimonial.find(params[:id])
    @staff_testimonial.destroy
    flash[:notice] = "Successfully destroyed Staff Testimonial."
    redirect_to admin_staff_testimonials_path
  end
  
end
