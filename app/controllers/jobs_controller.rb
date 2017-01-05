class JobsController < ApplicationController
  
  def index
    redirect_to "/page/careers#CurrentVacancies"
  end
  
  def show
    @job = Job.find(params[:id])
    @jobs = Job.active.order
    if !@job.active?
      redirect_to "/page/careers#CurrentVacancies"
    end
  end
  
end
