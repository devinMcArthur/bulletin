Rails.application.routes.draw do
 
  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
 
  get '/help'    => 'static_pages#help'
  get '/about'   => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  
  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  
  get '/signup'  => 'users#new'
  
  # Create RESTful functionality, and many named routes ('rails console' -> 'rails routes' to check) 
  resources :users
  resources :account_activations, only: [:edit]
  
end
