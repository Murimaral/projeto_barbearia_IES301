Rails.application.routes.draw do
  devise_for :users
  resources :pets do
    get :confirm_deactivation
    post :deactive
  end
  root to: 'pets#index'
end
