class PageNodesController < ApplicationController

  include PageContentsHelper

  def show

    @page_node = PageNode.find(params[:id])

		if @page_node.layout.to_s == "document"
			send_file("#{RAILS_ROOT}/public" + "#{@page_node.active_content.main_content}")
    end

    if @page_node.layout.to_s == "redirect"
      redirect_to("#{@page_node.active_content.main_content}")
    end

    if ((@page_node.id == 2)||(@page_node.id == 30)||(@page_node.id == 38)||(@page_node.id == 46))

			if @page_node.id == 30
				@case_study = CaseStudy.all(:conditions => {:service_id => 30}, :order => 'RAND()').first
				@faqs = Faq.seo_pap
			elsif @page_node.id == 38
				@case_study = CaseStudy.all(:conditions => {:service_id => 38}, :order => 'RAND()').first
				@faqs = Faq.seo_edm
			elsif @page_node.id == 2
				@case_study = CaseStudy.all(:conditions => {:service_id => 2}, :order => 'RAND()').first
				@faqs = Faq.seo_mds
			elsif @page_node.id == 46
        unless CaseStudy.all(:conditions => {:service_id => 46}).blank?
          @case_study = CaseStudy.all(:conditions => {:service_id => 46}, :order => 'RAND()').first
        else
          @case_study = CaseStudy.all(:conditions => {:service_id => 38}, :order => 'RAND()').first
        end
        unless Faq.seo_edm_for.blank?
          @faqs = Faq.seo_edm_for
        else
          @faqs = Faq.seo_edm
        end
			end

			@survey = Survey.find(:first, :order => 'RAND()')

			if request.post?
        if params[:name].blank? || (params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) || params[:enquiry].blank? || params[:postcode].blank? # || !verify_recaptcha
          flash[:alert] = "Please complete all fields"
        else
          Mailer.deliver_contact_us(params[:name], params[:email], params[:tel], params[:enquiry], params[:postcode], params[:product], params[:form])
          flash[:notice] = "Your enquiry has been sent."
          redirect_to :controller => "web", :action => "thank_you"
        end
      end

		end

    # try and call the helper method matching the layout
    begin
      send(@page_node.likely_layout)
    rescue Exception => e
      #logger.info e.to_yaml
    end

    if @page_node.controller? && @page_node.action?
    	redirect_to url_for(:controller => @page_node.controller, :action => @page_node.action)
    	return
    elsif @page_node.controller?
    	redirect_to url_for(@page_node.controller)
    	return
    end

  end

  def document_audit_request
    if (params[:name].blank? && params[:company_name].blank?) || params[:validation] != '3'
      flash[:error] = "Please enter either your name or the name of your company so that we can get back to you."
      redirect_to :action => "show", :id => params[:id], :email => params[:email], :phone => params[:phone]
		elsif (params[:email].blank? && params[:phone].blank?) || params[:validation] != '3'
			flash[:error] = "Please enter either an email or telephone number so that we can get back to you."
			redirect_to :action => "show", :id => params[:id], :name => params[:name], :company_name => params[:company_name]
		else
			Mailer.deliver_document_audit_request(params[:name], params[:company_name], params[:email], params[:phone])
			flash[:notice] = "Your enquiry has been sent."
			redirect_to :action => "show", :id => params[:id]
		end
  end

  def print_audit_request
    if params[:name].blank? && params[:company_name].blank?
      flash[:error] = "Please enter either your name or the name of your company so that we can get back to you."
      redirect_to :action => "show", :id => params[:id], :email => params[:email], :phone => params[:phone]
		elsif params[:email].blank? && params[:phone].blank?
			flash[:error] = "Please enter either an email or telephone number so that we can get back to you."
			redirect_to :action => "show", :id => params[:id], :name => params[:name], :company_name => params[:company_name]
		else
			Mailer.deliver_print_audit_request(params[:name], params[:company_name], params[:email], params[:phone])
			flash[:notice] = "Your enquiry has been sent."
			redirect_to :action => "show", :id => params[:id]
		end
  end

  def request_a_review
	  @page_node = PageNode.find(params[:id])
		if request.post?
			if params[:name].blank? || params[:company_name].blank? || params[:additional_info].blank? || params[:phone].blank? || (params[:email].blank? || !params[:email].match(/^[A-Z0-9_\.%\+\-\']+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)$/i))
				flash[:review] = "Please complete all fields"
				redirect_to page_node_path(@page_node), :name => params[:name], :company_name => params[:company_name], :email => params[:email], :phone => params[:phone], :additional_info => params[:additional_info]
			else
				Mailer.deliver_request_a_review(params[:name], params[:email], params[:phone], params[:company_name], params[:business_size], params[:additional_info], params[:form])
				flash[:notice] = "Your enquiry has been sent."
				page_node_path(@page_node)
			end
		end
  end

  def thank_you
    @page_node = PageNode.find(params[:page_node_id])

    if params[:name].blank? || (params[:email].blank? || !params[:email].match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)) || params[:post_code].blank? || params[:business_size].blank? || params[:enquiry].blank? # || !verify_recaptcha
      flash[:alert] = "Please complete all fields"
      redirect_to page_node_path(@page_node), :name => params[:name], :post_code => params[:post_code], :company_name => params[:company_name], :email => params[:email], :phone => params[:phone], :enquiry => params[:enquiry]
    else
      Mailer.deliver_request_a_review(params[:name], params[:email], params[:phone], params[:company_name], params[:business_size], params[:enquiry], params[:form], params[:post_code])
      flash[:notice] = "Your enquiry has been sent."
    end

  end

end
