class Admin::ArticlesController < Admin::AdminController
  
  handles_images_for Article

  def index
    # set the default ordering
    params[:search] ||= {}
  	params[:search][:order] ||= "descend_by_date"
    @search = Article.unrecycled.search(params[:search])
    @articles = @search.paginate(:page => params[:page], :per_page => 50)
  end

  def index_update
    params[:ids] ||= []
    @search = Article.unrecycled.search(params[:search])
    @articles = @search.paginate(:page => params[:page], :per_page => 50) 
    for article in @articles
      if params[:ids].include? article.id.to_s
        article.highlight = true
      else
        article.highlight = false
      end
      article.save
    end
    redirect_to :action => :index, :search => params[:search], :page => params[:page]
  end
  
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = "Successfully created Article."
      if Article.image_changes?(params[:article])
        redirect_to :action => "index_images", :id => @article.id
      else
        redirect_to admin_articles_path
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end  

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "Successfully updated Article."
      if Article.image_changes?(params[:article])
        redirect_to :action => "index_images", :id => @article.id
      else
        redirect_to admin_articles_path
      end
    else
      render :action => 'edit'
    end
  end

  def order
    params[:draggable].each_with_index do |id, index|
      Article.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Successfully destroyed Article."
    redirect_to admin_articles_path
  end
  
end
