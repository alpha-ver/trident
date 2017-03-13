Rails.application.routes.draw do
  resources :countries
  resources :cities
  resources :champs
  namespace :bet do
    resources :groups
  end
  namespace :bet do
    resources :types
  end
  resources :settings
  resources :bettypes
  namespace :xbet do
    resources :bets
  end
  namespace :xbet do
    resources :events
  end
  resources :commands
  resources :sports
  namespace :bet do
    resources :companies
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
