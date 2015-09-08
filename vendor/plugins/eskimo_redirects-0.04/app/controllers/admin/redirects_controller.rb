class Admin::RedirectsController < Admin::AdminController
  def index
    @redirects = Redirect.read_file
  end

  def create
    @redirects = []
    params[:redirects].each_value do |v|
      @redirects << [v["from"], v["to"], v["count"].to_i]
    end
    
    begin
      Redirect.write_file request.env["HTTP_HOST"], @redirects
    rescue RuntimeError => e
      flash[:notice] = e.message
      redirect_to params.merge(:action => "index")
    else
      redirect_to :action => "index"
    end
  end

  def restore
    Redirect.restore
    redirect_to :action => "index"
  end

  def convert
    Redirect.convert request.env["HTTP_HOST"], params[:from]
    redirect_to :action => "index"
  end

  def order
    order_array = params[:draggable]
    render :update  do |page|
      count = 0
      while count < order_array.length
        page["redirects_#{order_array[count]}_count"].value = count
        count = count + 1
      end
    end
  end
end
