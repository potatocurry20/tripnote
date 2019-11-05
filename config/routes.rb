Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'account/Activations'
  get 'plan_destinations/new'
  get 'plans/new'
  root 'top#home'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  
  get 'visited/new', to:'plans#visited_new'
  get '/:id/visited/index', to:'plans#visited_index'
  patch 'visited/create', to:'plans#visited_create'
  
  get ':id/destination_index', to:'plan_destinations#destination_index'
  get ':id/place_index', to:'plan_destinations#place_index'
  
  get 'plan_destinations/:id/destination_new', to:'plan_destinations#destination_new'
  get 'plan_destinations/:id/place_new', to:'plan_destinations#place_new'
  post 'plan_destinations/:id/gone', to:'plan_destinations#gone'
  post 'place_create', to:'plan_destinations#place_create'
 
  get 'destination_favorites/index'
  post '/destination_favorites', to: 'destination_favorites#create'
  delete '/destination_favorites', to: 'destination_favorites#destroy'
  
  resources :users
  resources :plans
  resources :plan_destinations
  resources :users do 
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
