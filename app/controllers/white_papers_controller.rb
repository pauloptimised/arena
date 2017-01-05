class WhitePapersController < ApplicationController
  
  def index
    @search = WhitePaper.active.reject{|x| !x.document?}
    @white_papers = @search.paginate(:page => params[:page], :per_page => 20)
  end  
  
  def show
    redirect_to :action => :index
  end
  
end
