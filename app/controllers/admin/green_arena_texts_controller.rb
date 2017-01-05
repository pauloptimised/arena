class Admin::GreenArenaTextsController < Admin::AdminController
  
  def index
    @search = GreenArenaText.unrecycled.search(params[:search])
    @green_arena_texts = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @green_arena_text = GreenArenaText.new
  end
  
  def create
    @green_arena_text = GreenArenaText.new(params[:green_arena_text])
    if @green_arena_text.save
      flash[:notice] = "Successfully created Green Arena Text."
      redirect_to admin_green_arena_texts_path
    else
      render :action => 'new'
    end
  end  
  
  def edit
    @green_arena_text = GreenArenaText.find(params[:id])
  end  
  
  def update
    @green_arena_text = GreenArenaText.find(params[:id])
    if @green_arena_text.update_attributes(params[:green_arena_text])
      flash[:notice] = "Successfully updated Green Arena Text."
      redirect_to admin_green_arena_texts_path
    else
      render :action => 'edit'
    end
  end  
  
  def order
    params[:draggable].each_with_index do |id, index|
      GreenArenaText.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  
  
  def destroy
    @green_arena_text = GreenArenaText.find(params[:id])
    @green_arena_text.destroy
    flash[:notice] = "Successfully destroyed Green Arena Text."
    redirect_to admin_green_arena_texts_path
  end
  
end
