Rails.application.routes.draw do

  mount MaintRecordx::Engine => "/maint_recordx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount MachineToolx::Engine => '/machine_toolx'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
