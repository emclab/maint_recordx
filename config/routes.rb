MaintRecordx::Engine.routes.draw do
  
  resources :maint_reports, :only => [:index]
  resources :maint_requests do
    resources :maint_reports
    collection do
      get :search
      get :search_results      
      get :stats
      get :stats_results
    end      
  end 
  resources :maint_reports do
    resources :replaced_parts
    collection do
      get :search
      get :search_results      
      get :stats
      get :stats_results
    end      
  end 
  
  root :to => 'maint_requests#index'
end
