# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def logo_colour?
    @logo_colour ||= "white"
    @logo_colour
  end
  
  def logo_colour(logo_colour)
    @logo_colour = logo_colour
  end
	
	def determine_page_node
		if @page_node
			@current_page_node = @page_node
		elsif PageNode.controller_action(params[:controller], params[:action]).first
			@current_page_node = PageNode.controller_action(params[:controller], params[:action]).sort_by{|x| x.position}.first
		elsif PageNode.controller_action(params[:controller], "").first
			@current_page_node = PageNode.controller_action(params[:controller], "").sort_by{|x| x.position}.first
		else
			nil
		end
	end
  
  def link_to_page(link_text, page_name, options={})
    page_node = PageNode.find_by_name(page_name)
    if page_node
      link_to(link_text, page_node.path, options)
    else
      link_to(link_text, "", options)
    end
  end
  
  def insert_into_head
    @insert_into_head = true
  end
  
end
