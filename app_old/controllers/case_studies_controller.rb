class CaseStudiesController < ApplicationController
  
  def index
  	if params[:tag]
  	  @title = "Case Studies: #{params[:tag]}"
      @search = CaseStudy.active.position.tagged_with(params[:tag].to_s, :on => "tags")
  	elsif params[:service]
  	  @title = "Case Studies: #{params[:service]}"
      service_id = PageNode.find_by_name(params[:service]).id
      @search = CaseStudy.active.position.with_service(service_id)
    else
      @title = "Case Studies"
      @search = CaseStudy.active.position
    end
    @case_studies = @search.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @case_study = CaseStudy.find(params[:id])
    unless @case_study.active?
      redirect_to case_studies_path
    end
  end
  
end
