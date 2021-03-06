Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "registrations"}

  devise_scope :user do
    post "/register_user" => "registrations#create"
  end

  as :user do
    get "/register", to: "registrations#new", as: "register"
  end

  resources :customers
  resources :employees
  resources :services
  resources :attendances

  resources :rescue_requests do
    get 'answer', to: 'rescue_requests#answer'
  end

  root to: 'home#index'
  get '/dashboard', to: 'pages#dashboard'
  get '/search', to: 'customers#searchpage'
  post '/search', to: 'customers#search'
  get '/ban', to: 'pages#ban'
  post '/ban', to: 'pages#destroy_user'
  get '/schedule', to: 'attendances#schedule'

  post '/register_user', to: 'registrations#create'
end
