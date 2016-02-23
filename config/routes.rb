Rails.application.routes.draw do

  get '/cart' => 'cart#index'
  get '/cart/clear' => 'cart#clearCart'
  get '/cart/:id' => 'cart#add'
  get '/cart/removeItem/:id' => 'cart#removeItem'
  get '/add_avatar' => 'users#add_avatar'
  get '/checkout' => 'checkout#index'
  get '/mystore' => 'users#user_store'
  get '/possible_stores' => 'stores#possible_stores'
  get '/attach_to_campaign' => 'campaigns#possible_campaigns'
  get '/fetch_comments' => 'comments#from_product', as: 'fetch_comments'
  get '/faq' => 'faq#index'
  get '/recipients' => 'landing#recipients'

  resources :admin
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Upmin::Engine => '/admin'
  root to: 'landing#index'

  resources :campaigns do
    resources :donations
    resources :supporters
    resources :stores
    get 'add_product', to: 'campaigns#add_product'
    post 'assign_product', to: 'campaigns#assign_product'
    resources :comments, module: :campaigns
    resources :orders
    resources :invites
  end
 devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users
  resources :products do
    member do
      put "like", to: "products#like"
      put "dislike", to: "products#dislike"
    end
    # resources :like, module: :products
    resources :comments, module: :products
  end
end
