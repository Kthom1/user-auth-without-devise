require './lib/constraints/auth_constraint'

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

  constraints(Constraints::AuthConstraint.new) do
    root to: 'users#edit'
  end

  root to: 'users#new' 
end
