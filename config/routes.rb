Rails.application.routes.draw do
  devise_for :users
  
  root to: 'groups#index'
  
  resources :groups do
    collection do
      # メンバーをリストに追加する
      get 'add_members_to_list'
    end
    resources :items, only: [:index, :new, :create]
  end
  
  resources :users do
    collection do
      # ユーザー検索フォーム表示ページ
      get 'search'
      # ユーザー検索結果表示ページ
      get 'search_result'
    end
  end

end