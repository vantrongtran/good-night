Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :health_check, only: :index
    end
  end
end
