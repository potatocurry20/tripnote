Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'account/Activations'
  get 'record_destinations/new'
  get 'plan_destinations/new'
  get 'records/new'
  get 'plans/new'
  root 'top#home'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get 'plan_destinations/:id/goneedit', to:'plan_destinations#goneedit'
  patch 'plan_destinations/:id/gone', to:'plan_destinations#gone'
  
  resources :users
  resources :plans
  resources :records
  resources :plan_destinations
  resources :record_destinations
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
