class TestimonialsController < ApplicationController
  
  def index
  	# if params[:service]
  	#   @title = "Testimonials: #{params[:service]}"
    #   service_id = PageNode.find_by_name(params[:service]).id
    #   @search = Testimonial.active.position.with_service(service_id)
    # else
    #   @title = "Testimonials"
    #   @search = Testimonial.active.position
    # end
    # @testimonials = @search.paginate(:page => params[:page], :per_page => 20)
    redirect_to case_studies_path
  end
  
  def show
    redirect_to case_studies_path
  end
  
end
