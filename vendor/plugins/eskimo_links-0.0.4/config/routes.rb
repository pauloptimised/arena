ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.resources :link_tiny_mces, :collection => {:remove            => :get,
                                                     :new_email_link    => :get,
                                                     :new_external_link => :get,
                                                     :new_internal_link => :get,
                                                     :insert            => :post,
                                                     :choices           => :post},
                                     :only => [:index]
  end
  
end
