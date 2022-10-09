Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products
  resources :users
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'

  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  # post 'products/cart', to: 'products#show_cart', as: 'show_cart'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "products#index"
end
