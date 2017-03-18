Rails.application.routes.draw do

  get 'page/index'
  get 'page/contact'
  get 'page/about'

  namespace :admin do
    resources :countries
    resources :champs
    resources :commands
    resources :sports
    resources :settings
  end

  resources :countries
  resources :cities
  resources :champs
  resources :commands
  resources :sports

  namespace :xbet do
    resources :bets
    resources :events
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
