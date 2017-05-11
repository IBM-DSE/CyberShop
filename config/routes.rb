Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    post 'scoring/score'
  end

  root 'company#home'

  get '/about', to: 'company#about'

end
