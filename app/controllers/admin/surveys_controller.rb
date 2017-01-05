class Admin::SurveysController < Admin::AdminController
  
  def index
    @search = Survey.unrecycled.position.search(params[:search])
    @surveys = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @survey = Survey.new
  end
  
  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      flash[:notice] = "Successfully created Survey."
      redirect_to admin_surveys_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated Survey."
      redirect_to admin_surveys_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Survey.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed Survey."
    redirect_to admin_surveys_path
  end
  
end