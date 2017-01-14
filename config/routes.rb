Rails.application.routes.draw do
  resources :shows, only: [:index]
  get 'shows/data'
end
