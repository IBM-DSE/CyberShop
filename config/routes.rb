Rails.application.routes.draw do

  get 'messages', to: 'messages#start'
  post 'messages', to: 'messages#create'

  root 'company#home'

  get '/about', to: 'company#about'

  resources :categories, only: :show
  resources :brands, only: :show
  resources :products, only: :show
  get '/products/:id/order', to: 'products#add_to_cart', as: :order_product
  get '/cart', to: 'products#cart', as: :cart

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    post 'scoring/score'
  end

end
