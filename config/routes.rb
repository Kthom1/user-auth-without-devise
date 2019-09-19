Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index' 

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'profile' => 'users#show'
  patch 'profile' => 'users#update'

  get 'forgot' => 'passwords#new'
  post 'forgot' => 'passwords#create'
  get 'reset' => 'passwords#edit'
  patch 'reset' => 'passwords#update'
end
