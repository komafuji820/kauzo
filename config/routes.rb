Rails.application.routes.draw do
  devise_for :users
  
  root to: 'groups#index'
  
  resources :groups do
    collection do
      get 'add_member'
    end
  end
  
  resources :users do
    collection do
      get 'search'
      get 'search_result'
    end
  end
  
end
