Rails.application.routes.draw do

  root 'orders#index'
  devise_for :users
  devise_scope :users do
    get "my_trucks/:user_id/index" => "my_trucks#index", as: "index_my_trucks"
    post "my_trucks/:user_id/new" => "my_trucks#create", as: "create_my_trucks"
    delete "my_trucks/:user_id/:id" => "my_trucks#destroy", as: "destroy_my_trucks"
  end

  resources :orders, only: [:update, :destroy, :edit, :new]    
  post "orders/confirm" =>  "orders#confirm"
  post "orders/done" =>  "orders#done"
  get "orders/display" =>  "orders#display"
  get "orders/search" => "orders#search"
  get 'orders/authority'  =>  'orders#authority'
  patch 'orders/switch' => 'orders#switch'
  get 'orders/switch' => 'orders#switch'

  get 'users/:id/edit'  =>  'users#edit'
  get 'users/manual'  =>  'users#manual'
  get 'users/download'  =>  'users#download_users'
  patch 'users/:id/edit' => 'users#update', as: 'users'
  delete    'users/:id/edit'   =>  'users#destroy'
  get    'users/:id/show'   =>  'users#show'
  get 'trucks/change' => 'trucks/change'
  post 'trucks/:id/my_truck_create/:my_truck_id' => 'trucks#my_truck_create', as: 'my_truck_copy'
  patch 'trucks/:id/my_truck_update/:my_truck_id' => 'trucks#my_truck_update', as: 'my_truck_change'

  resources :slots, :only => [:update, :edit, :show, :create, :new, :destroy]
  resources :powers, :only => [:create, :new, :index]
  resources :notices, :only => [:create, :destroy, :index]
  resources :trucks, :only => [:new, :create, :edit, :update, :index, :destroy, :show]
end
