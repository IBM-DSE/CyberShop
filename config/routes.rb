Rails.application.routes.draw do

  root 'company#home'

  get '/about', to: 'company#about'

  resources :categories, only: :show, param: :name

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    post 'scoring/score'
  end

end
