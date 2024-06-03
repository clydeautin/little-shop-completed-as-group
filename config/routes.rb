
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  # resources :merchants, only: :dashboard do
  #   get 'dashboard', on: :member
  # end

  get "/merchants/:merchant_id/dashboard", to: "merchants/dashboard#show"
  
  resources :merchants, only: [] do
    resources :invoices, only: [:index, :show], controller: 'merchants/invoices'
    resources :items, only: [:index, :show, :edit], controller: 'merchants/items'
  end

  patch "/merchants/:merchant_id/items/:item_id", to: "merchants/items#update"
  
  resources :admin, only: :index
end
