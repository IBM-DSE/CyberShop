Rails.application.routes.draw do
  root 'company#home'

  get '/about', to: 'company#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
