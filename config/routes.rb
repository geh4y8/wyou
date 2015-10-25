Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  resources :campaigns do
    resources :donations
    resources :supporters
  end
  devise_for :users
  resources :users
  resources :products
end
