Rails.application.routes.draw do
  devise_for :users
  resources :items
  # get 'home/index'
  get '/categories', to: 'categories#index'
  get 'items/user/:id', to: 'items#index', as: 'items_user_path'
  get 'items/category/:category', to: 'items#index', as: 'category_item'
  get '/search' => 'items#search', :as => 'search_page'
  root 'items#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
