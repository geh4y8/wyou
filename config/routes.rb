Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  resources :campaigns do
    resources :donations
    resources :supporters
    resources :stores
  end
  devise_for :users
  resources :users
  resources :products
end
