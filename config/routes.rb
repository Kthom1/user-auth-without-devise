Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'profile' => 'users#edit'
  patch 'profile' => 'users#update'

  get 'forgot' => 'passwords#new'
  post 'forgot' => 'passwords#create'
  get 'reset' => 'passwords#edit'
  patch 'reset' => 'passwords#update'

  root to: 'users#new' 
end
