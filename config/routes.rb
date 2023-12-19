Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'
  resources :groups
  resources :users do
    collection do
      get 'search'
      get 'add_member'
    end
  end
end
