ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.resources :redirects, :only => [:index, :create],
                                :collection => {:convert => :get, :restore => :get, :order => :post}
  end
  
end
