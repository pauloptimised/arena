class WebController < ApplicationController

  def index
    @articles = Article.active.select{|article| article.image?}
    @home_highlights = HomeHighlight.active.random
  end

  def site_down

  end

  def site_search
    if params[:search]
      results = Search.site(params[:search]).select{|x| x.active?}
      @results = results.paginate(:page => params[:page], :per_page => 10)
    else
      @results = []
    end
  end

  def site_map
    @roots = PageNode.active.roots
    @roots += PageNode.active.navigation.select{|x| x.parent && !x.parent.display_in_navigation? }
    @roots = @roots.sort_by{|x| x.name}
  end

  # Let the board know

  def let_the_board_know
    @page_node = PageNode.let_the_board_know
  end



  def deliver_let_the_board_know
		if (params[:email].blank? && params[:tel].blank?) # || !verify_recaptcha
			flash[:error] = "Please enter either an email or telephone number so that we can get back to you."
			redirect_to :controller => "web", :action => "let_the_board_know", :name => params[:name], :tel => params[:tel], :email => params[:email], :message_to_the_board => params[:message_to_the_board]
		else
			Mailer.deliver_let_the_board_know(params[:name], params[:tel], params[:email].blank? ? SiteSetting.like("Email (Let the board know)").first.value : params[:email], params[:message_to_the_board])
			flash[:notice] = "Your enquiry has been sent."
			redirect_to :controller => "web", :action => "thank_you"
		end
  end

  # Duplicate invoice

  def duplicate_invoice_request
    @page_node = PageNode.duplicate_invoice
  end

  def deliver_duplicate_invoice_request
		if params[:invoice_number].blank? || params[:email].blank? || params[:validation] != '3'
			flash[:error] = "Please complete both fields."
			redirect_to :controller => "web", :action => "duplicate_invoice_request", :invoice_number => params[:invoice_number], :email => params[:email]
		else
			Mailer.deliver_duplicate_invoice_request(params[:invoice_number], params[:email])
			flash[:notice] = "Your request has been sent."
			redirect_to :controller => "web", :action => "thank_you"
		end
  end

  # Contact us

  def contact_us
  	@page_node = PageNode.contact_us
  	@product = Product.find(params[:product]) if params[:product]
    @case_studies = CaseStudy.active.random.highlighted.tagged_with(@page_node.active_content.subscriptions, :any => true)
    unless @case_studies.empty?
      @case_study = @case_studies.first
    end
    @testimonials = Testimonial.active.random.tagged_with(@page_node.active_content.subscriptions, :any => true)
    unless @testimonials.empty?
      @testimonial = @testimonials.first
    else
      @testimonial = Testimonial.highlighted.random.first
      @testimonial ||= Testimonial.active.random.first
    end
    @survey = Survey.find(:first, :order => 'RAND()')
  end

  def deliver_contact_us
		if params[:email].blank? && params[:tel].blank?
			flash[:error] = "Please enter either an email or telephone number so that we can get back to you."
			redirect_to :controller => "web", :action => "contact_us", :name => params[:name], :email => params[:email], :tel => params[:tel], :enquiry => params[:enquiry], :product => params[:product]
		else
			Mailer.deliver_contact_us(params[:name], params[:email], params[:tel], params[:enquiry], params[:product])
			flash[:notice] = "Your enquiry has been sent."
			redirect_to :controller => "web", :action => "thank_you"
		end
  end

  # Newsletter subscription

  def deliver_newsletter_subscription
    if params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
      flash[:error] = "Please enter a valid email address."
      redirect_to :back
    else
      Mailer.deliver_newsletter_subscription(params[:email])
      flash[:notice] = "Thank you."
      redirect_to :back
    end
  end

  # SEO landing pages ------------------------------------------------------------------------------

  def demon_printers
    @case_studies = CaseStudy.all(:conditions => { :id => [10,65] })

    if request.post?
      if params[:name].blank? || (params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) || params[:post_code].blank? || params[:business_size].blank? # || !verify_recaptcha
        flash[:alert] = "Please complete all fields"
      else
        Mailer.deliver_demon_printers(params[:name], params[:email], params[:phone], params[:company_name], params[:business_size], params[:enquiry], params[:form], params[:post_code])
        flash[:notice] = "Your enquiry has been sent."
        redirect_to :controller => "web", :action => "thank_you"
      end
    end
  end


  def photocopiers_and_printers
    @survey = Survey.find(:first, :order => 'RAND()')
    @case_study = CaseStudy.with_service(30).first
    @faqs = Faq.seo_pap
    if request.post?
			if params[:name].blank? || (params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) || params[:enquiry].blank?  # || !verify_recaptcha
				flash[:alert] = "Please complete all fields"
			else
				Mailer.deliver_contact_us(params[:name], params[:email], params[:tel], params[:enquiry], params[:product], params[:form])
				flash[:notice] = "Your enquiry has been sent."
				redirect_to :controller => "web", :action => "thank_you"
			end
  	end
  end

  def electronic_document_management
    @survey = Survey.find(:first, :order => 'RAND()')
    @case_study = CaseStudy.with_service(38).first
    @faqs = Faq.seo_edm
    if request.post?
			if params[:name].blank? || (params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) || params[:post_code].blank? || params[:business_size].blank? || params[:enquiry].blank? # || !verify_recaptcha
				flash[:alert] = "Please complete all fields"
			else
				Mailer.deliver_request_a_review(params[:name], params[:email], params[:phone], params[:company_name], params[:business_size], params[:enquiry], params[:form], params[:post_code])
				flash[:notice] = "Your enquiry has been sent."
				redirect_to :controller => "web", :action => "thank_you"
			end
		end
  end

  def managed_document_service
    @survey = Survey.find(:first, :order => 'RAND()')
    @case_study = CaseStudy.with_service(2).first
    @faqs = Faq.seo_mds
    if request.post?
			if params[:name].blank? || (params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) || params[:post_code].blank? || params[:business_size].blank? || params[:enquiry].blank? # || !verify_recaptcha
				flash[:alert] = "Please complete all fields"
			else
				Mailer.deliver_request_a_review(params[:name], params[:email], params[:phone], params[:company_name], params[:business_size], params[:enquiry], params[:form], params[:post_code])
				flash[:notice] = "Your enquiry has been sent."
				redirect_to :controller => "web", :action => "thank_you"
			end
		end
  end

  def mds_the_document_experts
    if RAILS_ENV == "development"
      @case_studies = CaseStudy.find_by_sql("SELECT * FROM case_studies where id IN (1, 2, 3)")
    else
      @case_studies = CaseStudy.find_by_sql("SELECT * FROM case_studies where id IN (28, 59, 60)")
    end
  end

  def mds_the_document_experts_thank_you
  end

  def request_a_review
		if params[:name].blank? || params[:company_name].blank? || params[:post_code].blank? || params[:additional_info].blank? || params[:phone].blank? || (params[:email].blank? || !params[:email].match(/^[A-Z0-9_\.%\+\-\']+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)$/i))
			flash[:review] = "Please complete all fields"
			redirect_to :controller => "web", :action => params[:form]
		else
			Mailer.deliver_request_a_review(params[:name], params[:email], params[:phone], params[:company_name], params[:business_size], params[:additional_info], params[:form], params[:post_code])
			flash[:notice] = "Your enquiry has been sent."
			if params[:form] && params[:form] == "mds_the_document_experts"
        redirect_to :controller => "web", :action => "mds_the_document_experts_thank_you"
			else
        redirect_to :controller => "web", :action => "thank_you"
      end

		end
  end

end
