class Admin::WhitePapersController < Admin::AdminController
  
  handles_documents_for WhitePaper
  
  def index
    @search = WhitePaper.unrecycled.search(params[:search])
    @white_papers = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @white_paper = WhitePaper.new
  end
  
  def create
    @white_paper = WhitePaper.new(params[:white_paper])
    if @white_paper.save
      flash[:notice] = "Successfully created White Paper."
      redirect_to admin_white_papers_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @white_paper = WhitePaper.find(params[:id])
  end
  
  def update
    @white_paper = WhitePaper.find(params[:id])
    if @white_paper.update_attributes(params[:white_paper])
      flash[:notice] = "Successfully updated White Paper."
      redirect_to admin_white_papers_path
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      WhitePaper.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @white_paper = WhitePaper.find(params[:id])
    @white_paper.destroy
    flash[:notice] = "Successfully destroyed White Paper."
    redirect_to admin_white_papers_path
  end
  
end
