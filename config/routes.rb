Rails.application.routes.draw do
  devise_for :users
  resources :pets do
    get :confirm_deactivation
    post :deactive
  end
  
  resources :rescue_requests do
    get 'answer', to: 'rescue_requests#answer'
  end

  root to: 'pets#index'
  get '/dashboard', to: 'pages#dashboard'
  post '/search', to: 'pets#search'
end
