# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  before_filter :check_for_site_maintenance
  
  def check_for_site_maintenance
    if SiteSetting.find_by_name("Site Down For Maintenance").value == "true"
      unless current_administrator  
        unless params[:controller] == "web" && params[:action] == "site_down"
          redirect_to :controller => "web", :action => "site_down"
        end
      end
    end
    current_administrator
  end
  
	helper_method :current_administrator
	
	private
    
    def current_administrator_session
      return @current_administrator_session if defined?(@current_administrator_session)
      @current_administrator_session = AdministratorSession.find
    end
    
    def current_administrator
      return @current_administrator if defined?(@current_administrator)
      @current_administrator = current_administrator_session && current_administrator_session.record
    end
    
  protected  
    
    # def log_error(exception)
    # super(exception)
    #   begin
    #    if ENV['RAILS_ENV']=='production'
    #       AdminMailer.deliver_exception_snapshot(
    #         exception, 
    #         clean_backtrace(exception), 
    #         session.instance_variable_get("@data"), 
    #         params, 
    #         request.env)
    #     end
    #   rescue => e
    #     logger.error(e)
    #   end
    # end
    
end
