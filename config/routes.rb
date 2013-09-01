MaintRecordx::Engine.routes.draw do
  
  get "maint_reports/index"

  get "maint_reports/new"

  get "maint_reports/create"

  get "maint_reports/edit"

  get "maint_reports/update"

  get "maint_reports/show"

  get "maint_requests/index"

  get "maint_requests/new"

  get "maint_requests/create"

  get "maint_requests/edit"

  get "maint_requests/update"

  get "maint_requests/show"

  resources :maint_reports, :only => [:index]
  resources :maint_requests do
    resources :maint_reports
    collection do
      get :search
      put :search_results      
      get :stats
      put :stats_results
    end      
  end 
  resources :maint_reports do
    resources :replaced_parts
    collection do
      get :search
      put :search_results      
      get :stats
      put :stats_results
    end      
  end 
  
  root :to => 'maint_requests#index'
end
