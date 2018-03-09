Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'

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
  
  get '/courses' => 'courses#index'
  
  # Create RESTful functionality, and many named routes ('rails console' -> 'rails routes' to check) 
  resources :users
  resources :account_activations,    only: [:edit]
  resources :password_resets,        only: [:new, :create, :edit, :update]
  resources :courses,                only: [:new, :create, :destroy, :edit, :update, :show]
  resources :assignments,            only: [:create, :destroy, :edit, :update, :show]
  resources :requests,               only: [:new, :create, :show, :index, :update, :edit]
  resources :assignment_attachments, only: [:create, :destroy, :edit, :update]
  
  resources :courses do
    resources :assignments
  end
  
  resources :assignments do
    resources :assignment_attachments
  end
  
end
