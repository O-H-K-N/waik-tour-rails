Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries, only: %i[index] do
        resources :spots, only: %i[index], shallow: true
      end
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
end
