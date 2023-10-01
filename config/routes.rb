Rails.application.routes.draw do
  
  # ログイン、アカウント編集後、任意のページに推移させるための記述
  devise_for :users
  root to: "home#index"

  #サインアップページ「/users/sign_up」でエラーが発生した場合、「/users」にリダイレクトされるのを防ぐため
  #「devise_scope :users」以下の記述を追記して、任意のルーティングをさせています。
  devise_scope :user do
    get "/users", to: redirect("/users/sign_up")
  end
  
  namespace 'users' do #/users/が前にきます
    resource :account, only: [:show]
    resource :profile, only: [:show, :edit, :update]
  end

  #get "reservations/confirm" => "reservations#new"
  resources :reservations do
    collection do
      post "confirm", to:"reservations#confirm"
    end
  end

  resources :rooms do
    get :own, on: :collection
    get :search, on: :collection
  end

end
