Rails.application.routes.draw do
  devise_for :users
  
  root to: 'groups#index'
  
  resources :groups do
    collection do
      # メンバー追加用
      get 'add_members_to_list'
    end
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
