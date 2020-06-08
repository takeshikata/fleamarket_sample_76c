Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'products#index'

  resources :users, only: [:show, :edit, :update]
  resources :products do
    collection do
      get 'search'
    end
  end

end
