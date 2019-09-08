Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
