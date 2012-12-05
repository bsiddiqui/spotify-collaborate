Liveplaylist::Application.routes.draw do

resources :users
resources :search, :only => [:index, :new]
  resources :parties

  root :to => 'search#index'

  get "static_pages/home"

  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
  get '/logout', :to => 'sessions#destroy'

  get '/createplaylist', :to => 'parties#create'
  get '/search', :to => 'search#index'

  
end
