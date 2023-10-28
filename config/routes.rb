Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries, only: %i[index show]
      resources :spots, only: %i[index show edit] do
        resources :videos, only: %i[index]
      end
      resources :requests, only: %i[create]
      resources :news_lists, only: %i[index]
      resources :bookmarks, only: %i[index create destroy]
      post '/login', to: 'user_sessions#create'
      delete 'logout', to: 'user_sessions#destroy', as: :logout
      post '/register', to: 'users#create'
      resources :users do
        collection do
          get 'me'
        end
      end
    end
  end

  #管理者画面のルーティング設定
  namespace :admin do
    root to: 'requests#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index new edit create update show destroy]
    resources :countries, only: %i[index new edit create update show destroy]
    resources :spots, only: %i[index new edit create update show destroy]
    resources :videos, only: %i[index edit update show destroy]
    resources :requests, only: %i[index edit update show]
    resources :news_lists, only: %i[index new edit create update destroy]
  end
end
