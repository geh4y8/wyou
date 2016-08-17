Rails.application.routes.draw do

  mount RailsEmailPreview::Engine, at: 'emails'
  get '/beta' => 'landing#landing_2'
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
  get '/admin/orders' => 'admin#orders'
  get '/admin/products' => 'admin#products'
  get '/admin/campaigns' => 'admin#campaigns'
  get '/admin/users' => 'admin#users'
  get '/admin/campaigns/donations' => 'admin#donations'
  get '/remove_product_category' => 'categories#remove_product'
  get '/connect/confirm' => 'stripe#confirm'
  get '/possible_campaigns' => 'campaigns#possible_campaigns2'
  get '/reason_for_leaving' => 'users#reason_for_leaving'


  resources :admin do
    root to: 'admin#dashboard'
  end
  post 'assign_products', to: 'categories#assign_products'
  resources :categories do
    get 'remove_product_category' => 'categories#remove_product'
  end

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Upmin::Engine => '/admin'
  root to: 'landing#index'

  resources :campaigns do
    resources :donations
    resources :supporters
    resources :stores
    get 'invite_store_supporter' => 'campaigns#invite_store_supporter'
    post 'send_store_invite' => 'campaigns#send_store_invite'
    get 'send_store_invite' => 'campaigns#send_store_invite'
    get 'assign_category_options' => 'campaigns#assign_category_options'
    post 'assign_category' => 'campaigns#assign_category'
    get 'add_product', to: 'campaigns#add_product'
    post 'assign_product', to: 'campaigns#assign_product'
    get 'switch_campaign', to: 'campaigns#switch_campaign'
    post 'join_existing_campaign', to: 'campaigns#join_existing_campaign'
    resources :comments, module: :campaigns
    resources :orders do
      get 'add_shipping_confirmation', to: 'orders#add_shipping_confirmation'
      post 'assign_shipped', to: 'orders#assign_shipped'
    end
    resources :invites do
      root to: 'invites#new'
    end
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
   match "/404", :to => "errors#not_found", :via => :all
   match "/500", :to => "errors#not_found", :via => :all
end
