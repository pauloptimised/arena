class Admin::FeedbacksController < Admin::AdminController
  
  def index
    @search = Feedback.unrecycled.search(params[:search])
    @feedbacks = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.save
      flash[:notice] = "Successfully created Feedback."
      redirect_to admin_feedbacks_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @feedback = Feedback.find(params[:id])
  end
  
  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(params[:feedback])
      flash[:notice] = "Successfully updated Feedback."
      redirect_to admin_feedbacks_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      Feedback.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    flash[:notice] = "Successfully destroyed Feedback."
    redirect_to admin_feedbacks_path
  end
  
end
