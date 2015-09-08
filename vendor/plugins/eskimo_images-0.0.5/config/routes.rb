ActionController::Routing::Routes.draw do |map|

  map.connect ":controller/index_images/:id", :action => "index_images"
  map.connect ":controller/index_image/:id/:image", :action => "index_image"
  map.connect ":controller/index_image/:id/", :action => "index_image"
  map.connect ":controller/frame/:id/:image/:crop", :action => "frame"
  map.connect ":controller/execute_frame/:id/:image/:crop", :action => "execute_frame"
  map.connect ":controller/add_whitespace/:id/:image", :action => "add_whitespace"
  map.connect ":controller/add_whitespace_popup/:id/:image", :action => "add_whitespace_popup"
  
  map.namespace :admin do |admin|
    admin.resources :images, :except => [:show], :member => {:update_stored_images => :post, 
                                                             :pre_alter            => :get, 
                                                             :alter                => [:get, :post], 
                                                             :execute_alter        => :post, 
                                                             :index_edits          => :get,
                                                             :add_whitespace       => :get,
                                                             :add_whitespace_from_alter => :get}, 
                                                 :collection => {:execute_frame        => [:get, :post], 
                                                                 :update_stored_images => :post,
                                                                 :alter_file           => :get, 
                                                                 :execute_alter_file   => :post}
    admin.resources :image_tiny_mces, :member => {:insert => :get}, :collection => {:execute_frame => [:get, :post]}
  end

end
