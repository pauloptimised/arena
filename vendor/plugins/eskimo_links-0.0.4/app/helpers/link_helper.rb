module LinkHelper

  def link_options_for_select(selected, options={})
    selects = []
    if !options[:include_blank].blank?
      options[:include_blank] = "" if options[:include_blank] == true
      selects << [options[:include_blank].to_s, [nil]]
    end
    options[:page_node_reject] ||= nil
    for model in EskimoLinks.all_models
      group = [model.to_s.underscore.humanize.pluralize.titleize, []]
  		for object in model.send("unrecycled").sort_by{|x| x.name}
    		name = (object.name.length > 50) ? "#{object.name[0..50]}..." : object.name
    		if model == PageNode
    		  unless options[:page_node_reject] && options[:page_node_reject].call(object)
      		  group[1] << [name, url_for(object.path)]
      		end
    		else
    			group[1] << [name, url_for(object)]
    		end
  		end
  		selects << group
    end
    grouped_options_for_select(selects, selected)
  end

end
