Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries, only: %i[index] do
        resources :spots, only: %i[index], shallow: true
      end
      get '/set_country', to: 'countries#set_country'
      get '/many_video', to: 'videos#many_video'
    end
  end
end
