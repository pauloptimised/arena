class Admin::LinkTinyMcesController < Admin::AdminController

  include ActionView::Helpers::JavaScriptHelper

  layout "admin_popup"
  
  def choices
    link_text = params[:link_text]
    @unlink_option = (link_text.include?('<a') || link_text.include?('<A'))
    link_text = link_text.gsub('<A', '<a').gsub('</A', '</a')
    link_text = ActionController::Base.helpers.strip_links(link_text)
    session[:link_text] = escape_javascript(link_text)
  end
    
  def new_internal_link
  	@page_nodes = PageNode.all
  	@model_names = PageNode.models.collect{|pn| pn.model.underscore.humanize.pluralize.titleize}.uniq
  	@models = EskimoLinks.models
  	@object_list = []
  	for model in @models
  		group = [model.to_s.underscore.humanize.pluralize.titleize,[]]
  		for object in model.send("unrecycled").sort_by{|x| x.name}
  			group[1] << [((object.name.length > 50) ? "#{object.name[0..50]}..." : object.name), "#{object.id}!#!#{model}"]
  		end
  		@object_list << group
		end
  end

  def insert
    if params[:link_type] == "external"
      @tag_text = "http://" + params[:url]
    elsif params[:link_type] == "email"
      @tag_text = "mailto:" + params[:url]
    elsif params[:link_type] == "page"
      @tag_text = url_for(PageNode.find(params[:page_node_id]))
    elsif params[:link_type] == "object"
      object_name = params[:object_class_id].split("!#!").last
      object_id = params[:object_class_id].split("!#!").first
      @tag_text = url_for(object_name.constantize.send("find", object_id))
    elsif params[:link_type] == "remove"
      @tag_text = ""
    end
  end
end
