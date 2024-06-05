
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index' 

  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index], action: :show, controller: 'merchants/dashboard'
    resources :invoices, only: [:index, :show], controller: 'merchants/invoices'
    resources :items, only: [:index, :show, :edit, :new, :create], controller: 'merchants/items'
    resources :invoice_items, only: [:update]
  end

  patch "/merchants/:merchant_id/invoices/:id", to: "invoice_items#update"
  patch "/merchants/:merchant_id/items/:id", to: "merchants/items#update", as: "merchant_item_update"

  resources :admin, only: :index

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :new, :create]
    resources :invoices, only: [:index, :show]
  end

  patch "/admin/invoice_items/:id", to: "admin/invoice_items#update"
  patch "/admin/merchants/:id", to: "admin/merchants#update", as: "admin_merchant_update"
end