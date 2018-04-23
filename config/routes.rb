Rails.application.routes.draw do
  resources :arrivals, only: :index
  resources :departures, only: :index
end
