Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  resources :campaigns do
    resources :donations
    resources :supporters
    resources :stores
    get 'add_product', to: 'campaigns#add_product'
    post 'assign_product', to: 'campaigns#assign_product'
  end
  devise_for :users
  resources :users
  resources :products do
    member do
      put "like", to: "products#like"
      put "dislike", to: "products#dislike"
    end
    resources :like, module: :products
  end
end
