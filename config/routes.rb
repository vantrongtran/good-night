Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      post "login", to: "authentication#create"
      resources :health_check, only: :index
      resources :daily_sleeping_times, only: [:index, :create, :update, :destroy]
      resources :follows, only: [:index, :create, :destroy]
    end
  end
end
