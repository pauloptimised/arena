class CostCalculationsController < ApplicationController

	require 'net/http'

  def index 
    redirect_to new_cost_calculation_path
  end  

  def new
		@page_node = PageNode.cost_calculations
    @cost_calculation = CostCalculation.new(params[:cost_calculation])
  end

  def show
		@page_node = PageNode.cost_calculations
    @cost_calculation = CostCalculation.find(params[:id])
  end

  def create
    @cost_calculation = CostCalculation.new(params[:cost_calculation])
    if @cost_calculation.total_saving == 0
      flash[:notice] = "Please provide at least one non-zero value below in order to calculate your savings estimate."
      render :action => 'new'
    elsif @cost_calculation.save
			Mailer.deliver_cost_calculation(@cost_calculation)
      redirect_to cost_calculation_path(@cost_calculation.id)
    else
      render :action => 'new'
    end
  end
  
  def report
    @page_node = PageNode.cost_calculations
    @cost_calculation = CostCalculation.find(params[:id])
    render :layout => 'pdf'
  end
	
  def request_callback
    @cost_calculation = CostCalculation.find(params[:id])
    @cost_calculation.update_attribute(:call_back, true)
    Mailer.deliver_callback_request!(@cost_calculation.id, @cost_calculation.name, @cost_calculation.phone)
    flash[:notice] = "Thank you. A member of our staff will call you at the nearest available opportunity."
    redirect_to :action => 'show'
  end
  
  def email_report
    @cost_calculation = CostCalculation.find(params[:id])
    if request.post?
			html = Net::HTTP.get_response(URI.parse("http://#{ActionMailer::Base.default_url_options[:host]}/cost_calculations/#{@cost_calculation.id}/report")).body
			PDFKit.new(html).to_file("#{RAILS_ROOT}/public/cost_calculations/#{@cost_calculation.id}.pdf")
      Mailer.deliver_results!(@cost_calculation.total_saving, @cost_calculation.name, params[:message], @cost_calculation.email, params[:email], @cost_calculation.id)
      flash[:notice] = 'Email sent.'
      redirect_to :action => 'show'
    end
  end
  
end
