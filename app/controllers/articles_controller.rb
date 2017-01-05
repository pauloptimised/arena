class ArticlesController < ApplicationController

  def index
    if params[:tag]
    @title = "News: #{params[:tag]}"
      @search = Article.active.tagged_with(params[:tag].to_s, :on => "tags")
    else
      @title = "News"
      @search = Article.active
    end
    @articles = @search.paginate(:page => params.fetch(:page, 1), :per_page => 20)
  end

  def show
    @article = Article.active.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path
  end

end
