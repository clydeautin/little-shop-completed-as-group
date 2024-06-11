Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index' 

  resources :merchants, only: [:index] do
    get 'dashboard', to: 'merchants/dashboard#show', as: 'dashboard'
    resources :invoices, only: [:index, :show], controller: 'merchants/invoices'
    # resources :items, only: [:index, :show, :edit, :new, :create], controller: 'merchants/items'
    resources :items, except: [:destroy, :update], controller: 'merchants/items'
    resources :invoice_items, only: [:update]
    resources :discounts, controller: 'merchants/discounts'
  end

  patch "/merchants/:merchant_id/items/:id", to: "merchants/items#update", as: "merchant_item_update"

  resources :admin, only: :index

  namespace :admin do
    # resources :merchants, only: [:index, :show, :edit, :new, :create]
    resources :merchants, except: [:destroy, :update]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  # patch "/admin/invoice_items/:id", to: "admin/invoice_items#update"
  patch "/admin/merchants/:id", to: "admin/merchants#update", as: "admin_merchant_update"
end