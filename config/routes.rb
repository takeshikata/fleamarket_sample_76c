Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'products#index'

  resources :profiles, only: [:edit, :update]
  resources :addresses, only: [:edit, :update, :new, :create]
  resources :users, only: [:index, :show, :edit, :update]
  
  devise_scope :user do
    get "log_in", to: "users/sessions#new"
    get 'log_out', to: "users#log_out"
    delete 'log_out', to: 'users/sessions#destroy'
  end

  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end

    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
    post "", to: "evaluations#create"

    member do
      get 'purchase'
      get 'pay'
    end

  end

  resources :categories, only: [:index]
  resources :cards, only: [:new, :create, :show, :destroy]

  resources :users, only: [:index, :show] do
    collection do
      get :likes
    end
  end

end
