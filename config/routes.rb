Rails.application.routes.draw do
  resources :monetary_accounts
  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :bunqauth
  resources :monetary_accounts

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  get 'bunq', to: 'bunqauth#redirect', as: 'bunq'
  get 'bunqlogin', to: 'bunqauth#new', as: 'bunqlogin'
  get 'monetary_accounts_fetch', to: 'monetary_accounts#fetch', as: 'fetchaccounts'

end