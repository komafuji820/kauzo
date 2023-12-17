Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'
  resources :groups, only: [:index, :new, :create, :show, :edit, :update]
  resources :users do
    collection do
      get 'search'
    end
  end
end
