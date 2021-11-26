Rails.application.routes.draw do
  resources :countries
  get 'emi-data-service', to: 'countries#fetch_emi_data'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
