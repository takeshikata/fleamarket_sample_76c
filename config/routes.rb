Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'products#index'

  resources :users, only: [:show, :edit, :update]
  resources :products
end
