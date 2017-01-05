class Admin::HomeHighlightsController < Admin::AdminController
  
  handles_images_for HomeHighlight
  
  def index
    @search = HomeHighlight.unrecycled.search(params[:search])
    @home_highlights = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @home_highlight = HomeHighlight.new
  end
  
  def create
    @home_highlight = HomeHighlight.new(params[:home_highlight])
    if @home_highlight.save
      flash[:notice] = "Successfully created Home Highlight."
      if HomeHighlight.image_changes?(params[:home_highlight])
        redirect_to :action => "index_images", :id => @home_highlight.id
      else
        redirect_to admin_home_highlights_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @home_highlight = HomeHighlight.find(params[:id])
  end
  
  def update
    @home_highlight = HomeHighlight.find(params[:id])
    if @home_highlight.update_attributes(params[:home_highlight])
      flash[:notice] = "Successfully updated Home Highlight."
      if HomeHighlight.image_changes?(params[:home_highlight])
        redirect_to :action => "index_images", :id => @home_highlight.id
      else
        redirect_to admin_home_highlights_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      HomeHighlight.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @home_highlight = HomeHighlight.find(params[:id])
    @home_highlight.destroy
    flash[:notice] = "Successfully destroyed Home Highlight."
    redirect_to admin_home_highlights_path
  end
  
end
