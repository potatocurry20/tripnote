Rails.application.routes.draw do
  get 'account/Activations'
  get 'record_destinations/new'
  get 'plan_destinations/new'
  get 'records/new'
  get 'plans/new'
  root 'top#home'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  
  resources :users
  resources :plans
  resources :records
  resources :plan_destinations
  resources :record_destinations
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
