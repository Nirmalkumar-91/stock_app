Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  get 'my_portfolio', to: 'users#my_portfolio'
  devise_for :users
  root 'welcome#index'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'friendships#my_friends'
  get 'search_friends', to: 'friendships#search'
  resources :friendships, only: [:destroy, :create]
end
