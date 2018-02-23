Rails.application.routes.draw do

  get 'organizations/user_index'


  root "homes#index"
  
  devise_for :users
  # devise_for :users, controllers: {sessions: 'users/sessions'}


  resources :homes

  resources :admins

  resources :organizations
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
