ActionController::Routing::Routes.draw do |map|
  
  map.resources :articles,     :only => [:show, :index]
  map.resources :blog_entries, :only => [:show, :index]
  map.resources :case_studies, :only => [:show, :index]
  map.resources :categories,   :only => [:show, :index]
  map.resources :cost_calculations, :member => {:report => :get, :request_callback => :get, :email_report => [:get, :post]}
  map.resources :faqs,         :only => [:show, :index]
  map.resources :feedbacks,    :only => [:show, :index], :collection => {:deliver_feedback_form => :post, :thank_you => :get}
  map.resources :jobs
  map.resources :page_nodes,   :as => "page", :only => [:show], :member => {:show => :post, :request_a_review => :post, :document_audit_request => :post, :print_audit_request => :post}
  map.resources :products,     :only => [:show, :index]
  map.resources :staff_testimonials
  map.resources :surveys,      :only => [:show, :index]
  map.resources :testimonials, :only => [:show, :index]
  map.resources :white_papers, :only => [:show, :index]
  
  map.namespace :admin do |admin|
    admin.resources :jobs, :except => [:show]
    admin.resources :staff_testimonials,  :except => [:show]
    admin.resources :articles,            :except => [:show], :collection => {:index_update => :post}
    admin.resources :blog_entries,        :except => [:show]
    admin.resources :case_studies,        :except => [:show], :collection => {:order => :post, :index_update => :post}
    admin.resources :categories,          :except => [:show], :collection => {:order => :post}
    admin.resources :cost_calculations,   :except => [:show]
    admin.resources :cross_sells,         :except => [:show]
    admin.resources :faqs,                :except => [:show], :collection => {:order => :post}
    admin.resources :feedbacks,           :except => [:show]
    admin.resources :gallery_images,      :except => [:show], :collection => {:order => :post}
    admin.resources :galleries,           :except => [:show], :collection => {:order => :post}
    admin.resources :green_arena_texts,   :except => [:show]
    admin.resources :home_highlights,     :except => [:show]
    admin.resources :makes,               :except => [:show]
  	admin.resources :page_nodes,          :except => [:show], :collection => {:index_list => :get, :index_list_advanced => :get, :index_reorder => :get, :order => :post}, :member => {:branch => :get, :activate => :get, :toggle_display => :get}
    admin.resources :products,            :except => [:show], :collection => {:index_update => :post}
    admin.resources :surveys,             :except => [:show], :collection => {:order => :post}
    admin.resources :testimonials,        :except => [:show], :collection => {:order => :post, :index_update => :post}
    admin.resources :white_papers,        :except => [:show]
    admin.connect 'administrators/edit_self', :controller => 'administrators', :action => 'edit_self'
    admin.connect 'recycle_bin/index',        :controller => 'recycle_bin',    :action => 'index'
  end
  
  map.connect 'web/accessibility',                     :controller => 'web', :action => 'accessibility'
  map.connect 'web/contact_us',                        :controller => 'web', :action => 'contact_us'
  map.connect 'web/deliver_contact_us',                :controller => 'web', :action => 'deliver_contact_us'
  map.connect 'web/let_the_board_know',                :controller => 'web', :action => 'let_the_board_know'
  map.connect 'web/deliver_let_the_board_know',        :controller => 'web', :action => 'deliver_let_the_board_know'
  map.connect 'web/duplicate_invoice_request',         :controller => 'web', :action => 'duplicate_invoice_request'
  map.connect 'web/deliver_duplicate_invoice_request', :controller => 'web', :action => 'deliver_duplicate_invoice_request'
  map.connect 'web/index',                             :controller => 'web', :action => 'index'
  map.connect 'web/site_down',                         :controller => 'web', :action => 'site_down'
  map.connect 'web/site_map',                          :controller => 'web', :action => 'site_map'
  map.connect 'web/site_search',                       :controller => 'web', :action => 'site_search'
  map.connect 'web/thank_you',                         :controller => 'web', :action => 'thank_you'
  map.connect 'web/deliver_newsletter_subscription',   :controller => 'web', :action => 'deliver_newsletter_subscription'
  map.connect 'academiesshow',                         :controller => 'articles', :action => 'show', :id => 101
  # SEO
    map.connect 'photocopiers_and_printers',           :controller => 'page_nodes', :action => 'show', :id => 30
    map.connect 'electronic_document_management',      :controller => 'page_nodes', :action => 'show', :id => 38
    map.connect 'managed_document_service',            :controller => 'page_nodes', :action => 'show', :id => 2 
  # SEO request form submission
    map.connect 'request_a_review',                    :controller => 'web', :action => 'request_a_review'
  
  map.root :controller => "web", :action => "index"
  
end
