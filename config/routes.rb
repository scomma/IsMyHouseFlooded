Ismyhouseflooded::Application.routes.draw do
  root to: 'zones#index', as: 'zones'
  resources :zones, except: :index
  resources :reports
end
