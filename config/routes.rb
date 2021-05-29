Rails.application.routes.draw do
  devise_for :users
  resources :pets do
    get :confirm_deactivation
    post :deactive
  end
  
  resources :rescue_requests

  root to: 'pets#index'
  post '/search', to: 'pets#search'
end
