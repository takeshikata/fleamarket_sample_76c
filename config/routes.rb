Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'products#index'

  resources :users, only: [:show, :edit, :update]
  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
    member do
      get 'purchase'
      get 'pay'
    end
  end

  resources :cards, only: [:new, :create, :show, :destroy]

end
