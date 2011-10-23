Ismyhouseflooded::Application.routes.draw do
  root to: 'zones#index', as: 'zones'
  resources :zones, only: []
  resources :reports, only: [:new, :create]
  post 'reports/new' => 'reports#new'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
