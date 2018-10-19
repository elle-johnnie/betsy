Rails.application.routes.draw do
  root 'products#home'
  
  get "/auth/:provider/callback", to: "sessions#create"

  get 'sessions/login', to: "sessions#new" #page for a new session
  delete "/logout", to: "sessions#destroy", as: "logout"

  # get 'sessions/new', to: "sessions#create" #create a new session login
  # get 'sessions/destroy', to: "sessions#destroy" #delete a session logout
  resources :carts, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]



  resources :reviews
  resources :orders
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
