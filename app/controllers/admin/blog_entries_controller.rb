class Admin::BlogEntriesController < Admin::AdminController
  
  handles_images_for BlogEntry
  
  def index
    @search = BlogEntry.unrecycled.search(params[:search])
    @blog_entries = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def new
    @blog_entry = BlogEntry.new
  end
  
  def create
    @blog_entry = BlogEntry.new(params[:blog_entry])
    if @blog_entry.save
      flash[:notice] = "Successfully created Blog Entry."
      if BlogEntry.image_changes?(params[:blog_entry])
        redirect_to :action => "index_images", :id => @blog_entry.id
      else
        redirect_to admin_blog_entries_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @blog_entry = BlogEntry.find(params[:id])
  end
  
  def update
    @blog_entry = BlogEntry.find(params[:id])
    if @blog_entry.update_attributes(params[:blog_entry])
      flash[:notice] = "Successfully updated Blog Entry."
      if BlogEntry.image_changes?(params[:blog_entry])
        redirect_to :action => "index_images", :id => @blog_entry.id
      else
        redirect_to admin_blog_entries_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      BlogEntry.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @blog_entry = BlogEntry.find(params[:id])
    @blog_entry.destroy
    flash[:notice] = "Successfully destroyed Blog Entry."
    redirect_to admin_blog_entries_path
  end
  
end
