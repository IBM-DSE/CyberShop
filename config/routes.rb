Rails.application.routes.draw do

  get 'shipping', to: 'shipping#test'
  post 'shipping/score'

  get 'status', to: 'status#status'

  devise_for :customers, path: '/', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'company#home'
  get '/about', to: 'company#about'

  resources :categories, only: :show
  resources :brands, only: :show
  resources :products, only: :show
  resources :deals, only: :index
  get '/cart', to: 'products#cart', as: :cart
  get '/products/:id/order', to: 'products#add_to_cart', as: :order_product
  post '/products/order', to: 'products#add_multiple_to_cart', as: :order_products
  get '/products/:id/remove', to: 'products#remove_from_cart', as: :remove_product

  post 'messages', to: 'messages#create'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    post 'scoring/score'
  end

end
