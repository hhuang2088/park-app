Rails.application.routes.draw do
  devise_for :users
  root to: "spots#new"
  resources :spots
  post "users/update", to: "devise/registrations#update"
end
