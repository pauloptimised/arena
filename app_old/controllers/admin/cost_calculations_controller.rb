class Admin::CostCalculationsController < Admin::AdminController
  
  def index
    @search = CostCalculation.unrecycled.search(params[:search])
    @cost_calculations = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @cost_calculation = CostCalculation.new
  end
  
  def create
    @cost_calculation = CostCalculation.new(params[:cost_calculation])
    if @cost_calculation.save
      flash[:notice] = "Successfully created Cost Calculation."
      redirect_to admin_cost_calculations_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cost_calculation = CostCalculation.find(params[:id])
  end
  
  def update
    @cost_calculation = CostCalculation.find(params[:id])
    if @cost_calculation.update_attributes(params[:cost_calculation])
      flash[:notice] = "Successfully updated Cost Calculation."
      redirect_to admin_cost_calculations_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      CostCalculation.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @cost_calculation = CostCalculation.find(params[:id])
    @cost_calculation.destroy
    flash[:notice] = "Successfully destroyed Cost Calculation."
    redirect_to admin_cost_calculations_path
  end
  
end
