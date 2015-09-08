class FeedbacksController < ApplicationController
  
  def index
    @case_study = CaseStudy.highlighted.random.first
    @case_study ||= CaseStudy.active.random.first
    @testimonial = Testimonial.highlighted.random.first
    @testimonial ||= Testimonial.active.random.first
    @survey = Survey.find(:first, :order => 'RAND()')
    @search = Feedback.active
    @feedbacks = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    redirect_to :action => :index
  end
  
  def deliver_feedback_form
		if params[:email].blank? && params[:tel].blank?
			flash[:error] = "Please enter either an email or telephone number so that we can get back to you."
			redirect_to :action => "index", :name => params[:name], :email => params[:email], :tel => params[:tel], :enquiry => params[:feedback]
		else
			Mailer.deliver_feedback_form(params[:name], params[:email], params[:tel], params[:feedback])
			flash[:notice] = "Your feedback has been sent."
			redirect_to :action => "thank_you"
		end
  end
  
  def thank_you
    @case_study = CaseStudy.highlighted.random.first
    @case_study ||= CaseStudy.active.random.first
    @testimonial = Testimonial.highlighted.random.first
    @testimonial ||= Testimonial.active.random.first
    @survey = Survey.find(:first, :order => 'RAND()')
  end
  
end
