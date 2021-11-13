Rails.application.routes.draw do
  devise_for :users

  resources :pets do
    get :confirm_deactivation
    post :deactive
  end

  resources :customers
  resources :employees
  resources :services
  resources :attendances

  resources :rescue_requests do
    get 'answer', to: 'rescue_requests#answer'
  end

  root to: 'pets#index'
  get '/dashboard', to: 'pages#dashboard'
  get '/search', to: 'customers#searchpage'
  post '/search', to: 'customers#search'
  get '/ban', to: 'pages#ban'
  post '/ban', to: 'pages#destroy_user'
  get '/schedule', to: 'attendances#schedule'
end
