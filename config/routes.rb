Rails.application.routes.draw do
  devise_for :users
  root to: 'goals#index'
  patch 'update_js/:id', to: 'goals#update_js'

  resources :goals, except: [:index]
  resources :users, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
