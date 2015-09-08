class Admin::JobsController < Admin::AdminController
  
  handles_documents_for Job
  
  def index
    params[:search] ||= {}
    params[:search][:order] ||= "descend_by_closing_date"
    @search = Job.unrecycled.search(params[:search])
    @jobs = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = "Successfully created Job."
      redirect_to admin_jobs_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @job = Job.find(params[:id])
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = "Successfully updated Job."
      redirect_to admin_jobs_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Job.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = "Successfully destroyed Job."
    redirect_to admin_jobs_path
  end
  
end
