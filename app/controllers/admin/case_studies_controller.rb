class Admin::CaseStudiesController < Admin::AdminController
  
  handles_images_for CaseStudy
  
  def index
    @search = CaseStudy.position.unrecycled.search(params[:search])
    @case_studies = @search.paginate(:page => params[:page], :per_page => 50)
  end
  
  def index_update
    params[:ids] ||= []
    @search = CaseStudy.unrecycled.search(params[:search])
    @case_studies = @search.paginate(:page => params[:page], :per_page => 50) 
    for case_study in @case_studies
      if params[:ids].include? case_study.id.to_s
        case_study.highlight = true
      else
        case_study.highlight = false
      end
      case_study.save
    end
    redirect_to :action => :index, :search => params[:search], :page => params[:page]
  end
  
  def new
    @case_study = CaseStudy.new
  end
  
  def create
    @case_study = CaseStudy.new(params[:case_study])
    if @case_study.save
      flash[:notice] = "Successfully created Case Study."
      if CaseStudy.image_changes?(params[:case_study])
        redirect_to :action => "index_images", :id => @case_study.id
      else
        redirect_to admin_case_studies_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @case_study = CaseStudy.find(params[:id])
  end
  
  def update
    @case_study = CaseStudy.find(params[:id])
    if @case_study.update_attributes(params[:case_study])
      flash[:notice] = "Successfully updated Case Study."
      if CaseStudy.image_changes?(params[:case_study])
        redirect_to :action => "index_images", :id => @case_study.id
      else
        redirect_to admin_case_studies_path
      end
    else
      render :action => 'edit'
    end
  end
  
  def order
    params[:draggable].each_with_index do |id, index|
      CaseStudy.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def destroy
    @case_study = CaseStudy.find(params[:id])
    @case_study.destroy
    flash[:notice] = "Successfully destroyed Case Study."
    redirect_to admin_case_studies_path
  end
  
end
