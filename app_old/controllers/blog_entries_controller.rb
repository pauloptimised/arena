class BlogEntriesController < ApplicationController
  
  def index
  	params[:page] ||= 1
  	if params[:tag]
  	  @title = "Blog Entries: #{params[:tag]}"
      @search = BlogEntry.active.tagged_with(params[:tag].to_s, :on => "tags")
    elsif params[:year] && params[:month]
      @title = "Blog Entries: #{Date::MONTHNAMES[params[:month].to_i]} #{params[:year]}"
      @search = BlogEntry.active.year(params[:year]).month(params[:month])
    elsif params[:year]
      @title = "Blog Entries: #{params[:year]}"
    	@search = BlogEntry.active.year(params[:year])
    else
      @title = "Blog Entries"
      @search = BlogEntry.active
    end
    @blog_entries = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    @blog_entry = BlogEntry.find(params[:id])
    unless @blog_entry.active?
      redirect_to blog_entries_path
    end
  end
  
end
