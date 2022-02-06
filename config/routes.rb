Rails.application.routes.draw do
  devise_for :users
  root to: 'goals#index'
  patch 'update_js/:id', to: 'goals#update_js'

  get 'goals_completed', to: 'goals#goals_completed', as: 'completed'
  resources :goals, except: [:index]
  resources :users, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
