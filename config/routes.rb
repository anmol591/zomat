Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  post 'cuisines', to: 'items_order#display_cuisines'
  post 'category', to: 'items_order#display_categories'  
  post 'restaurants', to: 'items_order#search_restaurants'
  post 'order', to: 'items_order#place_order'
  get 'index', to: 'items_order#index'
  root 'items_order#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
