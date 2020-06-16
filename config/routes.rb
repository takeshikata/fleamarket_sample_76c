Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'products#index'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :profile, only: [:edit, :update]
    resource :address, only: [:edit, :update, :new, :create]
  end
  devise_scope :user do
    get "log_in", to: "users/sessions#new"
    get 'log_out', to: "users#log_out"
    delete 'log_out', to: 'users/sessions#destroy'
    # post 'log_out', to: 'users/sessions#destroy', via: Devise.mappings[:user].sign_out_via
  end

  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end

    resources :comments, only: :create

    member do
      get 'purchase'
      get 'pay'
    end

  end

  resources :cards, only: [:new, :create, :show, :destroy]

end
