Rails.application.routes.draw do
  resources :pets
  root to: 'pets#index'
end
