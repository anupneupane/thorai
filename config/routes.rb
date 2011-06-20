Purchest::Application.routes.draw do
  
  #ROUTES_PROTOCOL = (ENV["RAILS_ENV"] =~ /development/ ? "http" : "http")
  
  resources :discussions
  resources :invitations
  resources :orders
  resources :line_items
  resources :chests
  resources :profiles
  resources :daily_deal_mailings 
  resources :cities
  resources :deals
  resources :merchants
  resources :categories do
    resources :sub_categories
  end

  get "admin_tasks/home"  
  get "home/index"
  get "purchest_orders/index"
    
  match '/subscriptions/new' => 'subscriptions#new', :via => :get
  match '/subscriptions' => 'subscriptions#create', :via => :post
  match "/purchase" => "home#purchase"
  match "/purchase_complete" => "home#purchase_complete"
  

  devise_for :admins
  devise_for :users, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" } do
    get "/users/show_user_account", :to => "users/registrations#show_user_account" #, :as => 'account'
    get '/users/sign_up/:invitation_token', :to => 'users/registrations#new'
  end

  root :to => "home#index" #, :as => 'home'

end
