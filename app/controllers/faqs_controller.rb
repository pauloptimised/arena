class FaqsController < ApplicationController
  
  def index
    @search     = Faq.active.position.collect(&:question).uniq
    @uniqe_faqs = []
    @search.each { |faq| @uniqe_faqs.push Faq.find_by_question(faq) }
    if params[:tag]
      @search = @uniqe_faqs.tagged_with(params[:tag], :on => "tags")
    else
    	@search = @uniqe_faqs
    end  	
    @faqs = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    redirect_to :action => :index
  end
  
end
