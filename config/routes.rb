Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :arrivals, only: :index
      resources :departures, only: :index
    end
  end
end
