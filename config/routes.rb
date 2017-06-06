Rails.application.routes.draw do

  get 'messages', to: 'messages#start'
  post 'messages', to: 'messages#create'

  root 'company#home'

  get '/about', to: 'company#about'

  resources :categories, only: :show
  resources :brands, only: :show
  resources :products, only: :show

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    post 'scoring/score'
  end

end
