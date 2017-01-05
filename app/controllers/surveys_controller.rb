class SurveysController < ApplicationController
  
  def index
    @search  = Survey.active.position
    @surveys = @search.paginate(:page => params[:page], :per_page => 20)
    @page_node = PageNode.find_by_name("Customer Satisfaction")
  end
  
  def show
    redirect_to :action => :index
  end
  
end
