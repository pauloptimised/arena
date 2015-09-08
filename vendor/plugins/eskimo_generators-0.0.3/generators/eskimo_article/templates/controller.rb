class <%= plural_class_name %>Controller < ApplicationController
  
  def index
  	params[:page] ||= 1
  	if params[:tag]
  	  @title = ": #{params[:tag]}"
      @search = <%= class_name %>.active.tagged_with(params[:tag].to_s, :on => "tags")
    elsif params[:year] && params[:month]
      @title = ": #{Date::MONTHNAMES[params[:month].to_i]} #{params[:year]}"
      @search = <%= class_name %>.active.year(params[:year]).month(params[:month])
    elsif params[:year]
      @title = ": #{params[:year]}"
    	@search = <%= class_name %>.active.year(params[:year])
    else
      @title = ""
      @search = <%= class_name %>.active
    end
    @<%= plural_name %> = @search.paginate(:page => params[:page], :per_page => 20)
  end  

  def show
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    unless @<%= singular_name %>.active?
      redirect_to <%= plural_name %>_path
    end
  end
  
end
