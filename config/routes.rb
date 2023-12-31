Rails.application.routes.draw do

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :categories, only:[:index, :create, :edit, :update]
    resources :items, only: [:index, :show, :destroy] do
      resources :comment_lists, only: [:destroy]
    end

  end


  # 顧客用
  scope module: :public do
    root to: 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    get "home/about" => "homes#about", as: "about"
    get "customers/mypage" => "customers#show" #顧客のマイページ
    get "customers/mypage/edit" => "customers#edit" #顧客の登録情報編集画面
    patch "customers/update" => "customers#update" #顧客の登録情報更新
    get "customers/confirm" => "customers#confirm" #顧客の退会確認画面
    patch "customers/withdrawal" => "customers#withdrawal" #顧客の退会処理(ステータスの更新)
    get "/customers/post" => "customers#post" #投稿一覧画面（自分の投稿のみ）
    get "/customers/likes" => "customers#likes" #いいね一覧
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe' # 退会画面を表示
    patch '/customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal' # 退会処理(customerカラムのbooleanを更新)
    get "search_tag" => "items#search_tag" # タグの検索で使用する
    get 'searche' => 'items#search' #キーワード検索を表示

    resources :categories, only: [:show] #カテゴリごとの商品
    resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy, ] do
      resource :like_lists, only: [:create, :destroy]
      resources :comment_lists, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
