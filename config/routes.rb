Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries, only: %i[index] do
        resources :spots, only: %i[index edit]
      end
      get '/all_spot', to: 'spots#all_spot'
      get '/set_country', to: 'countries#set_country'
      get '/many_video', to: 'videos#many_video'
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
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index new edit create update show destroy]
    resources :countries, only: %i[index new edit create update show destroy]
    resources :spots, only: %i[index new edit create update show destroy]
    resources :videos, only: %i[index edit update show destroy]
  end
end
