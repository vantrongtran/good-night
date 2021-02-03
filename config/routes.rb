Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :health_check, only: :index
      post "login", to: "authentication#create"
      resources :daily_sleeping_times, only: [:index, :create, :update, :destroy]
    end
  end
end
