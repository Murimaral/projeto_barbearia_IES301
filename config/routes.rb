Rails.application.routes.draw do
  devise_for :users

  resources :pets do
    get :confirm_deactivation
    post :deactive
  end

  resources :customers
  resources :employees
  resources :services

  resources :rescue_requests do
    get 'answer', to: 'rescue_requests#answer'
  end

  root to: 'pets#index'
  get '/dashboard', to: 'pages#dashboard'
  get '/search', to: 'pets#searchpage'
  post '/search', to: 'pets#search'
  get '/ban', to: 'pages#ban'
  post '/ban', to: 'pages#destroy_user'
end
